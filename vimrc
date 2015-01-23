" vim: expandtab foldmethod=marker foldcolumn=2
"
" File: .vimrc
" Author: Spencer Whitt

let mapleader = " "
let g:mapleader = " "
let maplocalleader = "\\"

" Plugins {{{1

    " Vundle Setup {{{2

        set nocompatible              " be iMproved, required
        filetype off                  " required

        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()

        " let vundle manage itself
        Plugin 'gmarik/Vundle.vim'

    " Visual Appearance {{{2
        Plugin 'sjl/badwolf'
        Plugin 'altercation/vim-colors-solarized'
        " Plugin 'Lokaltog/vim-powerline'
        Plugin 'bling/vim-airline'

    " Text edit commands {{{2
        Plugin 'repeat.vim'
        Plugin 'godlygeek/tabular'
        Plugin 'mattn/emmet-vim'
        Plugin 'wojtekmach/vim-rename'
        " Plugin 'scrooloose/nerdcommenter'
        Plugin 'tpope/vim-commentary'
        Plugin 'vim-scripts/matchit.zip'
        Plugin 'nelstrom/vim-visual-star-search'

        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        " Plugin 'SirVer/ultisnips'

    " Text objects {{{2

        " These plugins collectively provide support for many useful text objects
        " ac, ic, aC, iC     : Columns of text
        " af{char}, if{char} : Everything between two instances of a character
        " ae, ie             : The entire buffer
        " az, iz             : a fold
        " ai, aI             : an indentation level
        Plugin 'kana/vim-textobj-user'
        Plugin 'tpope/vim-surround'
        Plugin 'coderifous/textobj-word-column.vim'
        Plugin 'thinca/vim-textobj-between'
        Plugin 'kana/vim-textobj-entire'
        Plugin 'kana/vim-textobj-fold'
        Plugin 'kana/vim-textobj-indent'

    " Management {{{2
        Plugin 'sessionman.vim'
        Plugin 'bufexplorer.zip'
        Plugin 'kien/ctrlp.vim'
        Plugin 'scratch.vim'

    " External Integration {{{2
        Plugin 'jamessan/vim-gnupg'
        Plugin 'tpope/vim-fugitive'
        Plugin 'airblade/vim-gitgutter'
        Plugin 'scrooloose/syntastic'
        Plugin 'rking/ag.vim'
        Plugin 'mileszs/ack.vim'

    " Additional Filetype Support {{{2
        Plugin 'tpope/vim-markdown'
        Plugin 'tpope/vim-haml'
        Plugin 'groenewege/vim-less'
        Plugin 'sophacles/vim-bundle-mako'
        Plugin 'saltstack/salt-vim'
        Plugin 'Glench/Vim-Jinja2-Syntax'
        Plugin 'wting/rust.vim'

    " End Vundle {{{2
        call vundle#end()
        filetype plugin indent on

" Appearance {{{1

    syntax on

    set guifont=Sauce\ Code\ Powerline:h14
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1

    " highlight ExtraWhitespace ctermbg=red guibg=red
    " match ExtraWhitespace /\s\+$/
    " augroup MyAutoCmd
    " autocmd BufWinEnter * if &modifiable  | match ExtraWhitespace /\s\+$/ | endif
    " autocmd InsertEnter * if &modifiable  | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
    " autocmd InsertLeave * if &modifiable  | match ExtraWhitespace /\s\+$/ | endif
    " autocmd BufWinLeave * if &modifiable  | call clearmatches() | endif
    " augroup END

    " Make collapsed folds look nice {{{2
        " http://dhruvasagar.com/2013/03/28/vim-better-foldtext
        function! NeatFoldText()
            let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
            let lines_count = v:foldend - v:foldstart + 1
            let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
            let foldchar = matchstr(&fillchars, 'fold:\zs.')
            let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
            let foldtextend = lines_count_text . repeat(foldchar, 8)
            let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
            return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
        endfunction
        " set foldtext=NeatFoldText()
    " }}}2

    if has('gui_running')
        " No extra gui crap in gvim
        set guioptions-=m
        set guioptions-=T
        set guioptions-=e
        set guioptions-=r
        set guioptions-=R
        set guioptions-=l
        set guioptions-=L
    else
        " gnome-terminal colorscheme fix
        set t_Co=256
        " Mouse support in terminal
        " set mouse=a
    endif

    " Force gnome-terminal to display colorscheme correctly
    "if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
        "set t_Co=256
    "endif
    " Less visual noise from listchars
    let g:solarized_visibility="normal"
    colorscheme solarized

    if has('gui_running')
        set background=light
    else
        set background=dark
    endif

    " Number column no wider than it needs to be
    set numberwidth=1

    " Display divider at 80 characters.
    set colorcolumn=81
    "let &colorcolumn=join(range(81,256),",")

    " Don't automatically wrap text. Color column is enough as a gentle reminder
    set textwidth=0

    set encoding=utf-8

    " Always show the status line; powerline
    set laststatus=2

    " Don't show mode below the status line, powerline handles this for us
    set noshowmode

    " Nice autocomplete bar
    set wildmenu
    set wildignore=*.o,*~,*.pyc

    " View command being typed
    set showcmd

    " Pretty invisibles
    "set listchars=tab:▸\ ,eol:¬
    "set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
    set list

    " Indicate if a line is wrapped
    set showbreak=❯

    " Set 5 lines to the cursor - when moving vertically using j/k
    set scrolloff=5
    set sidescrolloff=5

    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500


" Behavior {{{1

    " nnoremap gcw guw~l
    " nnoremap gcW guW~l
    " nnoremap gciw guiw~l
    " nnoremap gciW guiW~l
    " nmap gcaw gciw
    " nmap gcaW gciW
    " nnoremap gcis guis~l
    " nnoremap gc$ gu$~l
    " nnoremap gcgc guu~l
    " nnoremap gcc guu~l
    " vnoremap gc gu~l

    " Trim trailing whitespace
    nnoremap <leader>tw :%s/\s\+$//<cr>``

    nmap <leader>ts <leader>tw

    " Create a custom command for each one rather than using AddTabularPattern,
    " because this way I can put them directly in my vimrc, which is easier
    " command TabularizeStrings :Tabularize /"[^" ]*"/

    " Hard mode
    "nnoremap jj <nop>
    "nnoremap kk <nop>
    "nnoremap hh <nop>
    "nnoremap ll <nop>

    " Open new windows to the right or above
    set splitright
    set nosplitbelow

    " Put name of current file in titlebar
    set title

    " Tab character settings
    set ts=4 sts=4 sw=4 expandtab shiftround

    " Indenting
    set ai "Auto indent
    " Use language specific indenting instead
    set nosmartindent

    " Line numbering
    set number
    set relativenumber

    " Ctags
    set tags=tags;

    " Don't have to save buffers before opening new ones
    set hidden

    " Soft wrap
    set linebreak

    " gq command formats with par
    " set formatprg=par\ -r

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

    " Maximum amount of nested folds
    set foldnestmax=3

    " Turn backup off, most stuff is in git
    set nobackup
    set nowb
    set noswapfile

    " Disable Ex mode, which is just annoying
    nnoremap Q <nop>

    " Search {{{2
        " Ignore case when searching
        set ignorecase

        " When searching try to be smart about cases
        set smartcase

        " Highlight search results
        set hlsearch

        " Make search act like search in modern browsers
        set incsearch

" Key Bindings {{{1

    " Video to text project remotes
    " nnoremap <leader>rs :e scp://starfleet/~/src/video2text/<cr>
    " nnoremap <leader>rm :e scp://marr/~/video2text/<cr>

    "This allows for change paste motion cp{motion}
    nmap <silent> cp :set opfunc=ChangePaste<CR>g@
    function! ChangePaste(type, ...)
        silent exe "normal! `[v`]\"_c"
        silent exe "normal! p"
    endfunction

    " Enter key inserts a new line
    nnoremap <cr> o<esc>
    nnoremap <S-cr> O<esc>

    " Too lazy to hold shift
    " noremap ; ;
	" noremap : :

    " Force myself to move away from Esc, use Ctrl+c instead
    inoremap  <esc>  <nop>
    vnoremap  <esc>  <nop>
    cnoremap  <esc>  <nop>

    " Ctrl+c behaves different from esc in certain situations
    " eg: when making an edit from visual block mode
    inoremap  <C-c>  <esc>
    vnoremap  <C-c>  <esc>
    "cnoremap  <C-c>  <esc>

    " Tab navigation
    noremap <S-H> gT
    noremap <S-L> gt
    noremap <leader>tn :tabedit<CR>
    noremap <leader>tc :tabclose<CR>

    " Switch windows with ctrl
    noremap <C-j> <C-W>j
    noremap <C-k> <C-W>k
    noremap <C-h> <C-W>h
    noremap <C-l> <C-W>l

    " Move windows with Ctrl+Shift
    noremap <A-j> <C-W>J
    noremap <A-k> <C-W>K
    noremap <A-h> <C-W>H
    noremap <A-l> <C-W>L

    " Toggle folds
    nnoremap - za

    " Make Y behave like everyone else
    nnoremap Y y$

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
    nnoremap <silent> <leader>ss :setlocal spell!<cr>
    nnoremap <Leader>sj ]s
    nnoremap <Leader>sk [s
    nnoremap <Leader>sa zg]s
    nnoremap <Leader>sd 1z=
    nnoremap <Leader>sf z=

    " Disable highlight
    noremap <silent> <leader><cr> :noh<cr>

    " <Leader>cd: Switch to the directory of the open buffer
    nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

    " The * command should stay on the current word
    nnoremap * *``

    " Easier word deletion in insert mode
    inoremap <C-BS> <C-w>

    " Remap VIM 0 to first non-blank character
    " noremap 0 ^
    nnoremap 0 0

" File Explorer {{{1

    " TODO: Move these with other navigational things
    nnoremap <leader>de :Explore<cr>
    nnoremap <leader>dv :Vexplore<cr>
    nnoremap <leader>ds :Sexplore<cr>

    " Things to remember

    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    " Remember info about open buffers on close
    set viminfo^=%

" Filetype Settings {{{1

    " Make is pretty crappy about tabs vs spaces
    autocmd FileType make setlocal noexpandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2
    autocmd FileType haml setlocal ts=2 sts=2 sw=2
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2
    autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

    " Fix nanoc's yaml frontmatter syntax highlighting
    autocmd BufNewFile,BufRead *.md syntax match Comment /\%^---\_.\{-}---$/

    autocmd BufNewFile,BufRead *.j2 set syntax=jinja

    " Comment settings for cmake
    autocmd FileType cmake set commentstring=#\ %s

    " Open vimrc in a new tab
    " Mnemonic: Edit Vimrc
    nnoremap <leader>ev :e $MYVIMRC<CR>

    " Edit UltiSnips file for current file
    " Mnemonic: Edit Snips, Edit All
    nnoremap <leader>es :UltiSnipsEdit<cr>
    nnoremap <leader>ea :e ~/.vim/UltiSnips/all.snippets<cr>

    " Automatically source the vimrc file after saving it
    autocmd! bufwritepost .vimrc source $MYVIMRC
