" File: .vimrc
" Author: Spencer Whitt

" Install instructions:
" 1) git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 2) Move this file to your home directory
" 3) Launch vim and run :BundleInstall

let mapleader = " "
let g:mapleader = " "
let maplocalleader = "\\"

" Plugins {{{1

    " Vundle Setup {{{2

        " this section is required to initialize vundle
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()

        " let vundle manage itself
        Bundle 'gmarik/vundle'

    " Visual Appearance {{{2
        Bundle 'sjl/badwolf'
        Bundle 'Lokaltog/vim-powerline'

    " Text edit commands {{{2
        Bundle 'repeat.vim'
        Bundle 'godlygeek/tabular'
        Bundle 'mattn/zencoding-vim'
        Bundle 'wojtekmach/vim-rename'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'vim-scripts/matchit.zip'
        Bundle 'nelstrom/vim-visual-star-search'

        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        Bundle 'SirVer/ultisnips'

    " Text objects {{{2

        " These plugins collectively provide support for many useful text objects
        " ac, ic, aC, iC     : Columns of text
        " af{char}, if{char} : Everything between two instances of a character
        " ae, ie             : The entire buffer
        " az, iz             : a fold
        " ai, aI             : an indentation level
        Bundle 'kana/vim-textobj-user'
        Bundle 'tpope/vim-surround'
        Bundle 'coderifous/textobj-word-column.vim'
        Bundle 'thinca/vim-textobj-between'
        Bundle 'kana/vim-textobj-entire'
        Bundle 'kana/vim-textobj-fold'
        Bundle 'kana/vim-textobj-indent'

    " Management {{{2
        Bundle 'sessionman.vim'
        Bundle 'bufexplorer.zip'

    " External Integration {{{2
        Bundle 'tpope/vim-fugitive'
        Bundle 'airblade/vim-gitgutter'
        Bundle 'scrooloose/syntastic'
        Bundle 'rking/ag.vim'
        Bundle 'mileszs/ack.vim'

    " Additional Filetype Support {{{2
        Bundle 'tpope/vim-markdown'
        Bundle 'tpope/vim-haml'
        Bundle 'groenewege/vim-less'
        Bundle 'sophacles/vim-bundle-mako'

" Appearance {{{1

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
        set foldtext=NeatFoldText()
        " }}}2

    if has('gui_running')
        " No extra gui crap in gvim
        set guioptions-=m
        set guioptions-=T
        set guioptions-=e
    else
        " gnome-terminal colorscheme fix
        set t_Co=256
        " Mouse support in terminal
        set mouse=a
    endif

    " Force gnome-terminal to display colorscheme correctly
    "if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
        "set t_Co=256
    "endif

    colorscheme badwolf

    " Display divider at 80 characters. 
    " Highlight any text which flows over the limit
    set textwidth=80
    "set colorcolumn=+1
    let &colorcolumn=join(range(81,256),",")

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
    set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮


    " Indicate if a line is wrapped
    set showbreak=▸

    " Set 5 lines to the cursor - when moving vertically using j/k
    set scrolloff=5
    set sidescrolloff=5
    
    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500


" Behavior {{{1
    
    AddTabularPattern! strings /"[^"]*"/

    " Put name of current file in titlebar
    set title

    " Tab character settings
    set ts=4 sts=4 sw=4 expandtab shiftround

    " Indenting
    set ai "Auto indent
    " Use language specific indenting instead
    set nosmartindent

    " Line numbering
    set relativenumber

    " Ctags
    set tags=tags;

    " Improvements!
    set nocompatible

    " Enable file type detection
    filetype plugin indent on

    " Don't have to save buffers before opening new ones
    set hidden

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

    " Maximum amount of nested folds
    set foldnestmax=3

    " Turn backup off, most stuff is in git
    set nobackup
    set nowb
    set noswapfile

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

    "This allows for change paste motion cp{motion}
    " 
    nmap <silent> cp :set opfunc=ChangePaste<CR>g@
    function! ChangePaste(type, ...)
        silent exe "normal! `[v`]\"_c"
        silent exe "normal! p"
    endfunction

    " Enter key inserts a new line
    nnoremap <cr> o<esc>

    " Too lazy to hold shift
    noremap ; :
    noremap : ;

    " Force myself to move away from Esc, use Ctrl+c instead
    inoremap  <esc>  <nop>
    vnoremap  <esc>  <nop>
    cnoremap  <esc>  <nop>

    " Ctrl+c behaves different from esc in certain situations
    " eg: when making an edit from visual block mode
    inoremap  <C-c>  <esc>
    vnoremap  <C-c>  <esc>
    cnoremap  <C-c>  <esc>

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

    " Disable highlight
    noremap <silent> <leader><cr> :noh<cr>

    " The * command should stay on the current word
    nnoremap * *N

    " Easier word deletion in insert mode
    inoremap <C-BS> <C-w>

    " Remap VIM 0 to first non-blank character
    noremap 0 ^

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

    " Fix nanoc's yaml frontmatter syntax highlighting
    autocmd BufNewFile,BufRead *.md syntax match Comment /\%^---\_.\{-}---$/


" VIMRC Specific {{{1

    " Open vimrc in a new tab
    " Mnemonic: Edit Vimrc
    nnoremap <leader>ev :e $MYVIMRC<CR>

    " Edit UltiSnips file for current file
    " Mnemonic: Edit Snips, Edit All
    nnoremap <leader>es :UltiSnipsEdit<cr>
    nnoremap <leader>ea :e ~/.vim/UltiSnips/all.snippets<cr>

    " Automatically source the vimrc file after saving it
    autocmd! bufwritepost .vimrc source $MYVIMRC

    " vim: set foldmethod=marker foldcolumn=2:
