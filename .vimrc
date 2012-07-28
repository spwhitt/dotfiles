" File: .vimrc
" Author: Spencer Whitt
" Description: A file of vim awesome

" Install instructions:
" 1) git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 2) Move this file to your home directory
" 3) Launch vim and run :BundleInstall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugins                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "
let g:mapleader = " "
let maplocalleader = "\\"

filetype off " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage itself
Bundle 'gmarik/vundle'

" Bundle 'YankRing.vim'
" Bundle 'kien/ctrlp.vim'
Bundle 'bufexplorer.zip'
Bundle 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'sessionman.vim'

" Color scheme
" Force csapprox to use gui colors, even if terminal pretends it only supports
" 8 colors
Bundle 'CSApprox'
Bundle 'wgibbs/vim-irblack'
Bundle 'sjl/badwolf'

" Filetypes
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'groenewege/vim-less'
Bundle 'sophacles/vim-bundle-mako'

"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Utilities                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)

endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Settings                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""
"  Appearance  "
""""""""""""""""
set background=dark
colorscheme ir_black
" Fix wildmenu colors
hi WildMenu gui=italic guibg=#202020 guifg=yellow
" Force gnome-terminal to display colorscheme correctly
if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" No extra gui crap
set guioptions-=m
set guioptions-=T
set guioptions-=e

" Nice autocomplete bar
set wildmenu
set wildignore=*.o,*~,*.pyc

" View command being typed
set showcmd

" Line numbering
set number

" Pretty invisibles
set listchars=tab:▸\ ,eol:¬

" Indicate if a line is wrapped
set showbreak=▸

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

""""""""""""""
"  Behavior  "
""""""""""""""
" Improvements!
set nocompatible

" Enable file type detection
filetype plugin indent on

" Don't have to save buffers before opening new ones
set hidden

" Tab character settings
set ts=4 sts=4 sw=4 expandtab shiftround

" Indenting
set ai "Auto indent
set si "Smart indent

" Soft wrap
set linebreak

" gq command formats with par
set formatprg=par\ -r

" Set to auto read when a file is changed from the outside
set autoread

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""
"  Search  "
""""""""""""
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Make search act like search in modern browsers
set incsearch

""""""""""""
"  Backup  "
""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Key Bindings                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Too lazy to hold shift
noremap ; :
noremap : ;

" Save the Esc key
inoremap  jk     <Esc>
cnoremap  jk     <C-c>
vnoremap  jk     <ESC>
inoremap  <esc>  <nop>
vnoremap  <esc>  <nop>
cnoremap  <esc>  <nop>

" Tab navigation
noremap <S-H> gT
noremap <S-L> gt
noremap <leader>te :tabedit<CR>
noremap <leader>tc :tabclose<CR>

" Switch windows with ctrl
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
" Move windows with alt
noremap <A-j> <C-W>J
noremap <A-k> <C-W>K
noremap <A-h> <C-W>H
noremap <A-l> <C-W>L

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
noremap <leader>= <C-w>=

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Toggle spell check
nnoremap <silent> <leader>s :setlocal spell!<CR>

" Disable highlight
noremap <silent> <leader><cr> :noh<cr>

" Easier word deletion in insert mode
inoremap <C-backspace> <C-w>

" Remap VIM 0 to first non-blank character
noremap 0 ^

" Trim trailing whitespace
nnoremap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Fix indentation of entire file
nnoremap _= :call Preserve("normal gg=G")<CR>


"""""""""""""""""""""""""""
"  Easy Edit Preferences  "
"""""""""""""""""""""""""""

" Open vimrc in a new tab
" Mnemonic: Edit Vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Edit UltiSnips file for current file
" Mnemonic: Edit Snips
nnoremap <leader>es :vsplit<cr>:UltiSnipsEdit<cr>

" Automatically source the vimrc file after saving it
autocmd! bufwritepost .vimrc source $MYVIMRC

"""""""""""""""""""""""
"  Explorer Bindings  "
"""""""""""""""""""""""
" TODO: Move these with other navigational things
nnoremap <leader>de :Explore<cr>
nnoremap <leader>dv :Vexplore<cr>
nnoremap <leader>ds :Sexplore<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           File Type Settings                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make is pretty crappy about tabs vs spaces
autocmd FileType make setlocal noexpandtab

