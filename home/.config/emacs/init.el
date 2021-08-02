;;; init.el --- Spencer's Emacs Config
;;; Commentary:
;;;   Flycheck won't leave me alone unless I add this comment, and I'm
;;;   not yet good enough with Emacs to tell it to shut up
;;; Code:

(setq lexical-binding t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Integrate straight.el with use-package
;; (setq straight-use-package-by-default t)

;; Init straight.el
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;; 	(url-retrieve-synchronously
;; 	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;; 	 'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; Install use-package
;; (straight-use-package 'use-package)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(setq use-package-compute-statistics t)

;; Basic settings for emacs
;; wrapped in a use-package no-op because why not
(use-package emacs
  :init
  ;; Remove GUI Crap
  (when (window-system)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1))
  (setq use-dialog-box nil)

  ;; Hide Startup Crap
  (setq inhibit-startup-screen t)
  (setq inhibit-startup-message t)
  (setq initial-scratch-message nil)
  (setq inhibit-startup-echo-area-message t)

  ;; Tone down error bells to just a subtle flash of the modeline
  (setq visible-bell nil)
  (setq ring-bell-function
	(lambda ()
	  (invert-face 'mode-line)
	  (run-with-timer 0.1 nil #'invert-face 'mode-line)))

  ;; Configure Fonts
  (set-face-attribute 'default nil :font "Source Code Pro-11:weight=semi-light" )
  (set-frame-font "Source Code Pro-11:weight=semi-light" nil t)

  ;; Pleasant left and right margins
  (setq-default left-margin-width 1 right-margin-width 1)
  ;; (set-window-buffer nil (current-buffer)) ; Use them now.

  ;; Don't litter my filesystem
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (setq create-lockfiles nil)

  ;; automatically save files when the buffer changes
  ;; (auto-save-visited-mode)

  (set-fill-column 80)
  (global-display-fill-column-indicator-mode t)
  (column-number-mode)

  ;; Disable hostile keys
  (unbind-key "C-x C-r") ; find-file-read-only
  (unbind-key "C-X C-d") ; list-directory
  (unbind-key "<C-wheel-down>") ; zoom
  (unbind-key "C-x f") ; set fill column
  (unbind-key "M-c") ; Capitalize word - always hit this when trying to M-x

  ;; Handle whitespace automatically
  (add-hook 'before-save-hook #'delete-trailing-whitespace)
  (setq require-final-newline t)

  ;; Highlight matching paren
  (show-paren-mode))

;; Edit emacs config
(defun open-init-file ()
  "Open this very file."
  (interactive)
  (find-file "~/.dotfiles/home/.emacs.d/init.el"))

(bind-key "C-c e" #'open-init-file)

;; Setup packages
(use-package racket-mode
  :mode "\\.rkt\\'"
  :interpreter "racket"
  :ensure t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  )

(use-package evil
  :ensure t
  :config
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-want-fine-undo t)
  (setq evil-move-beyond-eol t) ; recommended for cleverparens
  (evil-mode 1)
  (evil-define-key '(visual insert) 'global (kbd "M-SPC") 'evil-normal-state)
  ;; (evil-define-key '(visual normal) 'global (kbd "xb") 'eval-buffer)

  ;; Windows / Buffers
  (evil-define-key '(visual insert normal) 'global (kbd "M-j") 'evil-window-down)
  (evil-define-key '(visual insert normal) 'global (kbd "M-k") 'evil-window-up)
  (evil-define-key '(visual insert normal) 'global (kbd "M-h") 'evil-window-left)
  (evil-define-key '(visual insert normal) 'global (kbd "M-l") 'evil-window-right)
  (evil-define-key '(visual insert normal) 'global (kbd "M-c") 'evil-window-delete)
  (evil-define-key '(visual insert normal) 'global (kbd "M-d") 'evil-delete-buffer)

  ;; No redo actually accessible because we're using emacs undo
  ;; But this is nevertheless a reasonable placeholder
  (evil-define-key '(visual normal) 'global (kbd "U") 'evil-redo)
  (evil-define-key 'normal 'global (kbd "C-r") nil)
  )

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-light-hard t))

(use-package magit
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode 1))

(use-package paredit
  :disabled
  :ensure t
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))

;; Enable smartparens
(use-package smartparens
  :disabled
  :ensure t
  :config
  (require 'smartparens-config))

;; fuzzy completion
;; (setq ido-use-filename-at-point 'guess)
;; (ido-mode 1)
;; (ido-everywhere 1)

(use-package xah-fly-keys
  :disabled
  :ensure t
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

; (add-hook 'Scheme #'evil-cleverparens-mode)

(use-package fingers
  :disabled
  :ensure t
  :config
  )

(use-package fingers-qwerty
  :disabled
  :ensure t
  :after fingers

  ;;(require 'fingers)
  ;;(require 'fingers-qwerty)
  (setq fingers-region-specifiers fingers-qwerty-region-specifiers)
  (setq fingers-keyboard-layout-mapper 'fingers-workman-to-qwerty)
  (fingers-reset-bindings))

;; Icons
;; Tried it - didn't excite me. I like the old fashioned clean text.
(use-package all-the-icons
  :disabled
  :ensure t)

(use-package all-the-icons-dired
  :disabled
  :ensure t
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; init.el ends here
