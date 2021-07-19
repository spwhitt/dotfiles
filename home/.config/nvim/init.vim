scriptencoding utf-8

" vim: expandtab foldmethod=marker

" Plugins {{{1
call plug#begin('~/.local/share/nvim/plugged')

" Conservative Extensions to Vim {{{2

" Open file with line number
Plug 'bogado/file-line'

" Text Objects {{{3
" Prefixes: Pair (i), A Pair (a), Inside Pair (I), Around Pair (A)
"           Next pair: (in) (an) (In) (An)
"           Last pair: (il) (al) (Il) (Al)
" Add additional separators: @
let g:targets_separators = ', . ; : + - = ~ _ * # / | \ & $ @'
Plug 'wellle/targets.vim'

" ---
" Library for writing text object plugins like the ones below
" See: https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'

" ---
" io, ao: Columns of indentation (whitespace)
Plug 'glts/vim-textobj-indblock'

" ---
" aS, iS: Whitespace
Plug 'saihoooooooo/vim-textobj-space'

" ---
" al, il: A line
" TODO: This plugin conflicts with target's bindings
"Plug 'kana/vim-textobj-line'

" ---
" ac, ic, aC, iC: Columns of text
Plug 'coderifous/textobj-word-column.vim'

" ---
" af{char}, if{char} : Everything between two instances of a character
Plug 'thinca/vim-textobj-between'

" ---
" ae, ie: The entire buffer
Plug 'kana/vim-textobj-entire'

" ---
" az, iz: a fold
Plug 'kana/vim-textobj-fold'

" ---
" ai, ii, aI, iI: an indentation level
Plug 'kana/vim-textobj-indent'
" }}}3

" Bindings {{{3
" --
" Collection of highly useful pairs of mappings
" ]q [q: Forward and back in the quickfix list
Plug 'tpope/vim-unimpaired'

" ---
" Allow plugins to extend Vim's . command
Plug 'tpope/vim-repeat'

" ---
" Extends Vim's % command
Plug 'vim-scripts/matchit.zip'

" ---
" Motions based on indent depths or levels
Plug 'jeetsukumaran/vim-indentwise'

" ---
" Allow you to use * on a visual selection
Plug 'nelstrom/vim-visual-star-search'

" ---
" I can hardly function without these text objects
" s<char> where char is practically any symbol or t
Plug 'tpope/vim-surround'
" }}}3

" --
" Display visual indication of current indent level
" Plug 'Yggdroot/indentLine'

Plug 'lifepillar/vim-mucomplete'

" Text edit commands {{{2

" Align text
" :Tab /pattern
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Toggle comments in code
" gc<motion>: Toggle command
" gcc: Toggle line
" gcu: Uncomment adjacent lines
" gc: Text object
Plug 'tpope/vim-commentary'

" Automatically set up indentation settings based on file
Plug 'tpope/vim-sleuth'

" Colorschemes {{{2
" Plug 'mhartington/oceanic-next'
" Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
" Plug 'chriskempson/base16-vim'
Plug 'jeffkreeftmeijer/vim-dim'

" External Integration {{{2

" Linters, Fixers, and LSP!
Plug 'desmap/ale-sensible' | Plug 'dense-analysis/ale'

" Compilers, Test Programs, ETC
Plug 'tpope/vim-dispatch'

" Send text to a REPL
Plug 'jpalardy/vim-slime'

" :Delete: Delete a buffer and the file on disk simultaneously.
" :Unlink: Like :Delete, but keeps the now empty buffer.
" :Move: Rename a buffer and the file on disk simultaneously.
" :Rename: Like :Move, but relative to the current file's containing directory.
" :Chmod: Change the permissions of the current file.
" :Mkdir: Create a directory, defaulting to the parent of the current file.
" :Cfind: Run find and load the results into the quickfix list.
" :Clocate: Run locate and load the results into the quickfix list.
" :Lfind/:Llocate: Like above, but use the location list.
" :Wall: Write every open window. Handy for kicking off tools like guard.
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit: Edit a privileged file with sudo.
" File type detection for sudo -e is based on original file name.
" New files created with a shebang line are automatically made executable.
Plug 'tpope/vim-eunuch'

" Plug 'let-def/vimbufsync'

Plug 'tpope/vim-fugitive'

"  Disabled for now
" let g:gitgutter_enabled = 0
" Plug 'airblade/vim-gitgutter'

" Some improvements to vim's :grep
Plug 'mhinz/vim-grepper'

" FZF {{{3
" Install Vim Plugin Packaged with FZF
Plug '/run/current-system/sw/share/vim-plugins/fzf'

" Additional FZF Commands/Features
" Downgrade for now because fzf packaged with nixos isn't recent enough
" Prefix all commands with Fzf for clarity
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
Plug 'junegunn/fzf.vim', { 'commit': '4145f53f3d343c389ff974b1f1a68eeb39fba18b' }

"}}}3

" Filetype / Syntax Plugins {{{2
" let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'derekelkins/agda-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-markdown'
"Plug 'tpope/vim-haml'
Plug 'groenewege/vim-less'
"Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'wting/rust.vim'
Plug 'vim-jp/vim-cpp'
Plug 'lgeorget/maude.vim'
" Plug 'lambdatoast/elm.vim'
" Plug 'keith/swift.vim'
Plug 'wlangstroth/vim-racket'
Plug 'LnL7/vim-nix'

" COQ
" Plug 'trefis/coquille'
" Plug 'jvoorhis/coq.vim'
" Plug 'vim-scripts/CoqIDE'

" MISC {{{2
" ---
" Keybinding hints
" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" ---
" A small taste of structured editing
" Plug 'kovisoft/paredit'
Plug 'guns/vim-sexp'

Plug 'tpope/vim-obsession'

" Notetaking {{{2
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/Data/Dropbox/Notes/', 'syntax': 'markdown', 'ext':'.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown':'markdown', '.mdown':'markdown'}
" Include extension in the markdown link [text](text.md) instead of [text](text)
" Allows other programs to follow the links more easily
let g:vimwiki_markdown_link_ext = 1
" }}}2
"}}}2

call plug#end()
" Plugin Config {{{1

let g:fzf_action = {
      \ 'alt-space': 'abort',
      \}

" For vim-sexp to recognize file
" let g:sexp_filetypes += 'racket'

" Use :terminal to host REPL
let g:slime_target='neovim'

" ALE settings
" Enabling ale completion is definitely a bad idea - it overrides sensible settings
" let g:ale_completion_enabled = 1
" Or use this to combine with mucomplete?
set omnifunc=ale#completion#OmniFunc
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'nix' : [ 'nixfmt' ],
      \ 'vim': [ 'trim_whitespace', 'remove_trailing_lines' ],
      \}

" Disable raco for now because racket-langserver seems more feature complete
let g:ale_linters = {
      \ 'racket': [ 'racket-langserver' ]
      \}
" nnoremap K :ALEGoToDefinition<cr>

call ale#linter#Define('racket', {
      \   'name': 'racket-langserver',
      \   'lsp': 'stdio',
      \   'executable': 'racket',
      \   'command': 'racket -l racket-langserver',
      \   'project_root': '/home/swhitt/Data/Projects/research/mKanren',
      \})

" MuComplete
set completeopt=preview
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c
set belloff+=ctrlg

let g:mucomplete#chains = {
      \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
      \ 'vim'     : ['path', 'cmd', 'keyn'],
      \ 'ocaml'   : ['omni'],
      \ 'racket'  : ['omni']
      \ }

imap <c-h> <plug>(MUcompleteCycBwd)
imap <c-l> <plug>(MUcompleteCycBwd)
imap <c-j> <plug>(MUcompleteFwd)
imap <c-k> <plug>(MUcompleteBwd)

" Appearance {{{1
" If there is a .nvimrc or .exrc in the current directory, read it (securely)
" Enables project-specific configuration
" set exrc
" set secure

let mapleader = ' '
let g:mapleader = ' '

" Localleader is meant to be like leader but for commands local to the current
" buffer.  I've rarely seen it actually used
let maplocalleader = '\\'

" I'm not interested in forcing the current window to be particularly large
set winheight=4
set winwidth=8

" Allow windows to shrink significantly, but not become invisible
set winminheight=4
set winminwidth=8

" Open Help in current window, like everything else
function! OpenHelpInCurrentWindow(topic)
  try
    view $VIMRUNTIME/doc/help.txt
    setl filetype=help
    setl buftype=help
    setl nomodifiable
    setl nolist
    exe 'keepjumps help ' . a:topic
  endtry
endfunction
command! -nargs=? -complete=help Help call OpenHelpInCurrentWindow(<q-args>)
nnoremap <silent> <leader>h :help<cr>

" Line numbering disabled for a clean look
set nonumber
set norelativenumber

" Theme
let myterm = $TERM
if myterm=~?'linux'
  " In a TTY, use 16 color theme
  set background=dark
  colorscheme dim
else
  " Not in a TTY, go full true color support
  set background=light
  let g:gruvbox_contrast_light='hard'
  let g:gruvbox_italic=1
  set termguicolors
  colorscheme gruvbox
endif

" Always show signcolumn to prevent text moving left/right on error
set signcolumn=yes

" Alternative: Show signs in number column. Vim only?
" set signcolumn=number
" set number

" No background color on sign column - cleaner appearance
highlight clear signcolumn

" Don't need a status bar when there's only one window
set laststatus=1

" Customize how collapsed folds look
function! CustomFold()
  return printf('  ### %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction
set fillchars=fold:\ | set foldtext=CustomFold()

" Make collapsed folds look nice {{{2
" http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" function! NeatFoldText()
"     let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
"     let lines_count = v:foldend - v:foldstart + 1
"     let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
"     let foldchar = matchstr(&fillchars, 'fold:\zs.')
"     let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
"     let foldtextend = lines_count_text . repeat(foldchar, 8)
"     let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
"     return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
" endfunction
" set foldtext=NeatFoldText()
" }}}2

" Number column no wider than it needs to be
set numberwidth=1

" Display line at 80 characters to remind me to break long lines
set colorcolumn=81

" Don't automatically wrap text. Color column is enough as a gentle reminder
set textwidth=0

" Things to ignore from wildmenu completion
set wildignore=*.o,*~,*.pyc

" Pretty invisibles
set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:±,trail:⋅
set list

" Indicate if a line is wrapped
set showbreak=❯

" Not wrapping is prettier, but you must know how to scroll right: zL
set nowrap

" Scroll screen 4 lines before cursor hits top/bottom
set scrolloff=4
set sidescrolloff=4

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" Properly disable sound on errors on MacVim
if has('gui_macvim')
  augroup macvim_vb
    autocmd!
    autocmd GUIEnter * set vb t_vb=
  augroup END
endif

" }}}1
" Behavior {{{1

" Do I need this if I have grepper?
" TODO: Convert this to grepper
if executable('rg')
    set grepprg=rg\ --vimgrep\ --hidden
endif

" Mouse support
set mouse=a

" Use system clipboard by default
set clipboard=unnamedplus

" Same split behavior as tmux
set nosplitright
set nosplitbelow

" Allow files to set vim settings
set modeline

" Put name of current file in titlebar
set title

" Disable softtabstop and shiftwidth, so that tabstop is the only setting
" Tab settings in Vim are crazy... and this makes it simple like it should be
set softtabstop=0
set shiftwidth=0

" Round indent to multiple of shiftwidth when using > and <
" This is nice to make < and > fix the indentation level
set shiftround

" Default: Use 2 spaces for tabs
set expandtab
set tabstop=2

" Don't have to save buffers before switching to new ones
" This is important for this vimrc's intended workflow to work well:
" e.g. opening a Unite buffer momentarily in the current window
set hidden

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show partial command in last line of screen
set showcmd

" For regular expressions turn magic on
set magic

" Maximum amount of nested folds
set foldnestmax=3

" Turn backup off, most stuff is in git
set nobackup
set nowritebackup
set noswapfile

" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Return to last edit position when opening files
" autocmd BufReadPost *
"             \ if line("'\"") > 0 && line("'\"") <= line("$") |
"             \   exe "normal! g`\"" |
"             \ endif

" Remember open buffers on close
" set viminfo^=%

" Remember undo history
if has('persistent_undo')
  " set undodir='$HOME/.vim/undo'
  " set undofile
endif

" }}}1
" Key Bindings {{{1

" Don't move cursor on visual yank
" Less unexpected cursor movements and side effects = better
vnoremap <expr>y "my\"" . v:register . "y`y"

" ---
" Minimal Vim
"
" Here I disable useless keys, so that I will not use them and can reclaim
" them for other uses in the future

" Ex mode is annoying and useless. Only masochists use it.
nnoremap Q <nop>

" Equivalent to cc
" Remapped to use for fzf searching below
nnoremap S <nop>

" Equivalent to cl
" Remapped to use for splits + windows below
nnoremap s <nop>

" Equivalent to j^, which is a strange thing to want anyway
nnoremap _ <nop>
xnoremap _ <nop>

" Equivalent to :s, which is much easier to remember (repeat previous substitute)
nnoremap & <nop>

" Equivalent to j
nnoremap + <nop>
xnoremap + <nop>

" Equivalent to k
nnoremap - <nop>
xnoremap - <nop>

" Equivalent to dl
nnoremap x <nop>
xnoremap x <nop>

" Equivalent to dh
nnoremap X <nop>
xnoremap X <nop>

" \ already does nothing, but include it here as a reminder
nnoremap \ <nop>

" ---
" Reclaim U as redo
nnoremap U <C-R>

" Remove old redo binding to force switch
nnoremap <C-r> <nop>

" Reclaim S for use in the surround plugin. This is consistent with surround's
" visual mode S mapping. This is a recursive mapping intentionally.
nmap S ys
nmap SS yss

" Trim trailing whitespace
nnoremap <leader>tw :%s/\s\+$//<cr>``
nmap <leader>ts <leader>tw

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
  silent exe 'normal! `[v`]"_c'
  silent exe 'normal! p'
endfunction

" Use Ctrl-Space as <esc>
"  - It's easier to type than <esc>, Ctrl-c, Ctrl-[, etc. (when caps = ctrl)
"  - It doesn't cause issues in visual mode like jk
"  - Its recognized in (my) terminal
inoremap <C-Space> <esc>`^
xnoremap <C-Space> <esc>
cnoremap <C-Space> <C-c>
onoremap <C-Space> <esc>
" Neovim's terminal window - bindings to escape
tnoremap <C-Space> <C-\><C-n>
" Breaks <esc> binding in Fzf
" tnoremap <esc> <C-\><C-n>
" Here's the fix to make esc work in FZF
augroup fzf
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  autocmd! FileType fzf tnoremap <buffer> <M-Space> <c-c>
augroup END
augroup netrw
  autocmd!
  " Consistent help behavior with fugitive
  autocmd! FileType netrw nmap g? <F1>
augroup END

" Alt+space already works (as esc) by default, in fact alt+any key works...
cnoremap <M-Space> <esc>
xnoremap <M-Space> <esc>
onoremap <M-Space> <esc>
tnoremap <M-Space> <C-\><C-n>

" Hard mode - forces new habits
inoremap <esc> <nop>
nnoremap <esc> <nop>
cnoremap <esc> <nop>
xnoremap <esc> <nop>
onoremap <esc> <nop>

" Only highlight first 200 cols (performance)
set synmaxcol =200

" Tab navigation
noremap <S-H> gT
noremap <S-L> gt

" Split control (and tabs)
noremap ss :split<cr>
noremap sh :split<cr>
noremap sv :vsplit<cr>
noremap sd :close<cr>
noremap sj <C-W>j
noremap sk <C-W>k
noremap sh <C-W>h
noremap sl <C-W>l
noremap sJ <C-W>J
noremap sK <C-W>K
noremap sH <C-W>H
noremap sL <C-W>L
noremap st :tabnew<cr>
noremap sn :bn<cr>
noremap sp :bp<cr>
" switch to previously viewed buffer
noremap s6 <C-^><cr>
noremap s= <C-W>=
noremap s+ <C-W>_<C-W>\|
noremap s<Left> :tabprev<cr>
noremap s<Right> :tabnext<cr>

inoremap <C-s>p :split<cr>

" Delete a buffer without changing the splits
nnoremap <Space>d :bprevious\|:bdelete #<cr>
nnoremap <M-d> :bprevious\|:bdelete #<cr>

" Alt is more convenient to hit than Ctrl
" And it generally works in most modes (netrw, fugitive...)
nnoremap <M-c> :close<cr>
nnoremap <M-j> <C-W>j
nnoremap <M-k> <C-W>k
nnoremap <M-h> <C-W>h
nnoremap <M-l> <C-W>l
nnoremap <M-J> <C-W>J
nnoremap <M-K> <C-W>K
nnoremap <M-H> <C-W>H
nnoremap <M-L> <C-W>L

nnoremap <F2>f :FzfFiles<cr>
nnoremap <F2>g :Gstatus<cr>
nnoremap <F2>b :FzfBuffers<cr>
nnoremap <F2>L :FzfLines<cr>
nnoremap <F2>T :FzfTags<cr>

" Searching
" S is not need for switch because it's easy to use cl (Change Left)
" It is much better used for this!
" Mnemonic: Search X
nnoremap Sf :FzfFiles<cr>
nnoremap Sg :FzfGFiles<cr>
nnoremap Sb :FzfBuffers<cr>
" nnoremap Sc :FzfColors!<cr> ???? duplicate binding, not necessary anyway
" nnoremap Sag :FzfAg ???? Needs better binding, ag installed, pattern entry
" nnoremap Srg :FzfRg ???? Needs better binding, rg installed, pattern entry
nnoremap SL :FzfLines<cr>
nnoremap Sl :FzfBLines<cr> " ???? Does this add anything over /
nnoremap ST :FzfTags<cr>
nnoremap St :FzfBTags<cr> " ???? Duplicate Binding
nnoremap Sm :FzfMarks<cr>
" nnoremap sw :FzfWindows<cr> " Not likely to be useful
" nnoremap Sl :FzfLocate "Locate db not generated
nnoremap Sr :FzfHistory<cr>
nnoremap S: :FzfHistory:<cr>
nnoremap S/ :FzfHistory/<cr>
" Requires Ultisnips
" nnoremap Ss :FzfSnippets!<cr>
nnoremap SG :FzfCommits<cr>
" nnoremap SG :FzfBCommits!<cr> " Duplicate Binding
nnoremap Sc :FzfCommands<cr>
nnoremap Sh :FzfHelptags<cr>
nnoremap St :FzfFiletypes<cr>

" Toggle folds
" nnoremap - za

" Time based history navigation
nnoremap - g-
nnoremap + g+

" Make Y behave like everyone else
nnoremap Y y$

" g0 does what 0 used to
" nnoremap 0 ^

" Completion;
" Tags
inoremap <C-]> <C-x><C-]>
" Filename
inoremap <C-f> <C-x><C-f>
" Definition
inoremap <C-d> <C-x><C-d>
" Line
inoremap <C-l> <C-x><C-l>
" Dictionary
" inoremap <C-k> <C-x><C-k>

" Adjust viewports to the same size
" noremap <leader>= <C-w>=

" For when you forget to sudo.. Really Write the file.
" cmap W w !sudo tee % >/dev/null

" Toggle spell check
" nnoremap <silent> <leader>ss :setlocal spell!<cr>
" nnoremap <Leader>sj ]s
" nnoremap <Leader>sk [s
" nnoremap <Leader>sa zg]s
" nnoremap <Leader>sd 1z=
" nnoremap <Leader>sf z=

" Disable highlight with Esc or equivalent key
noremap <silent> <leader><cr> :nohlsearch<cr>
noremap <silent> <C-Enter> :nohlsearch<cr>
noremap <silent> <C-Space> :nohlsearch<cr>
noremap <silent> <esc> :nohlsearch<cr>
nnoremap <silent> <M-Space> :nohlsearch<cr>

" <Leader>cd: Switch to the directory of the open buffer
nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

" The * command should stay on the current word
" nnoremap * *``

" Easier word deletion in insert mode
inoremap <C-BS> <C-w>

" TODO: Move these with other navigational things
nnoremap <leader>de :Explore<cr>

" }}}1
" Filetype Settings {{{1

" Make is pretty crappy about tabs vs spaces
augroup filetype_settings
  autocmd!
  " autocmd FileType make setlocal noexpandtab

  " autocmd BufRead */TVS/* setlocal noexpandtab

  " autocmd FileType ruby setlocal ts=2 sts=2 sw=2
  " autocmd FileType haml setlocal ts=2 sts=2 sw=2
  " autocmd FileType yaml setlocal ts=2 sts=2 sw=2
  " autocmd FileType haskell setlocal ts=2 sts=2 sw=2
  " autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

  " Fix nanoc's yaml frontmatter syntax highlighting
  " autocmd BufNewFile,BufRead *.md syntax match Comment /\%^---\_.\{-}---$/

  " autocmd BufNewFile,BufRead *.j2 set syntax=jinja

  " Comment settings for cmake
  " autocmd FileType cmake set commentstring=#\ %s
augroup END

" Open vimrc in a new tab
" Mnemonic: Edit Vimrc
noremap <leader>ev :e $MYVIMRC<CR>

" Automatically source the vimrc file after saving it
augroup reload_vimrc
  autocmd!
  autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END
"}}}1
