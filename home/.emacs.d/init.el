;; Add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Enable paredit
;; (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;; (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;; (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;; (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;; (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; Enable smartparens

;; automatically save files when the buffer changes
;; (auto-save-visited-mode)

;; stop creating those #auto-save# files
(setq auto-save-default nil)

;; fuzzy completion
;; (setq ido-use-filename-at-point 'guess)
;; (ido-mode 1)
;; (ido-everywhere 1)
(ivy-mode 1)

;; ;; (require 'xah-fly-keys)
;; ;; (xah-fly-keys-set-layout "qwerty")
;; ;; (xah-fly-keys 1)

;; (require 'smartparens-config)

;; Simplify UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t) 
; (setq ring-bell-function 'ignore)
(setq visible-bell nil)
; Visible bell - subtle flash of modeline
(setq ring-bell-function
      (lambda ()
	(invert-face 'mode-line)
	(run-with-timer 0.1 nil #'invert-face 'mode-line)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; (require 'evil)
;; (evil-mode 1)
