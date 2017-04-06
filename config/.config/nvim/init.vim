" vim: expandtab foldmethod=marker
"
" File: .vimrc
" Author: Spencer Whitt
"
" Leader: A key often used to prefix custom commands. Even if you don't use it,
" plugins will. Many people recommend using ',' as leader. I disagree, because
" ',' is a useful key
set t_Co=256
let mapleader = " "
let g:mapleader = " "

" Localleader is meant to be like leader but for commands local to the current
" buffer.  I've rarely seen it actually used
let maplocalleader = "\\"

" I'm not interested in forcing the current window to be particularly large
set winheight=4
set winwidth=8

" Allow windows to shrink significantly, but not become invisible
set winminheight=4
set winminwidth=8

" Open Help in current window, like everything else
function! OpenHelpInCurrentWindow(topic)
    view $VIMRUNTIME/doc/help.txt
    setl filetype=help
    setl buftype=help
    setl nomodifiable
    setl nolist
    exe 'keepjumps help ' . a:topic
endfunction
command! -nargs=? -complete=help Help call OpenHelpInCurrentWindow(<q-args>)
nnoremap <silent> <leader>h :Help

" Use za to toggle the folds below

" Plugins {{{1

    call plug#begin('~/.vim/bundle')

    " Sensible {{{2

        " Plugins so good they should be Vim defaults
        " These plugins are the most important part of this Vim config
        " If you take nothing else away, take these. Everyone should have them.

        " ---
        " A collection of highly unobjectionable improvements to Vim defaults
        Plug 'tpope/vim-sensible'

        " --
        " Collection of highly useful pairs of mappings
        " ]q [q: Forward and back in the quickfix list
        Plug 'tpope/vim-unimpaired'

        " ---
        " Allow plugins to extend Vim's . command
        Plug 'repeat.vim'

        " ---
        " Extends Vim's % command
        Plug 'vim-scripts/matchit.zip'

        " ---
        " Allow you to use * on a visual selection
        Plug 'nelstrom/vim-visual-star-search'

        " ---
        " I can hardly function without these text objects
        " s<char> where char is practically any symbol or t
        Plug 'tpope/vim-surround'

        " ---
        " Massive collection of text objects
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
        " ai, aI: an indentation level
        Plug 'kana/vim-textobj-indent'

        " ---
        " Lightweight improvements to status bar

        " Don't show mode below the status line, airline handles this for us
        set noshowmode

        " " Turn this on to use powerline symbols
        " let g:airline_powerline_fonts=0

        " " Disable sep symbols. Takes less space, doesn't require weird fonts, etc.
        let g:airline_left_sep = ''
        " let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        " let g:airline_right_alt_sep = ''

        " Use short mode text (save space)
        let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }

        let g:airline_theme='oceanicnext'

        let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

        " " Required in order to make the below tweaks
        " if !exists('g:airline_symbols')
        "     let g:airline_symbols = {}
        " endif

        " " Unicode symbols for various things
        " " let g:airline_symbols.linenr = '␊'
        " " let g:airline_symbols.linenr = '␤'
        " " let g:airline_symbols.linenr = '¶'
        " let g:airline_symbols.branch = '⎇'
        " let g:airline_symbols.branch = ''
        " " let g:airline_symbols.paste = 'ρ'
        " " let g:airline_symbols.paste = 'Þ'
        " " let g:airline_symbols.paste = '∥'
        " let g:airline_symbols.whitespace = 'Ξ'

        " " I like to see my buffers across the top
        " let g:airline#extensions#tabline#enabled = 1
        " let g:airline#extensions#tabline#show_buffers = 1

        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        Plug 'Yggdroot/indentLine'

        " Plug 'itchyny/lightline.vim'
        " let g:lightline = { }
        " let g:lightline.component = {'readonly': '%{&readonly?"-":""}' }
        " let g:lightline.mode_map = {
        "     \ 'n' : 'N',
        "     \ 'i' : 'I',
        "     \ 'R' : 'R',
        "     \ 'v' : 'V',
        "     \ 'V' : 'V-L',
        "     \ "\<C-v>": 'V-B',
        "     \ 'c' : 'C',
        "     \ 's' : 'S',
        "     \ 'S' : 'S-L',
        "     \ "\<C-s>": 'S-B',
        "     \ 't': 'TERM',
        "     \ }
        " call lightline#init()

        let g:vimfiler_as_default_explorer = 1
        Plug 'Shougo/vimfiler.vim'


    " Experimental {{{2

        " Plugins I'm just messing with
        " I may not use these much, or at all

        " ---
        " Plug 'jamessan/vim-gnupg'

        " ---
        " Write HTML, XML, etc more quickly by expanding from an abbreviated form
        " Expand abbreviation with: <c-y>,
        " Almost all other emmet keybindings are better accomplished with
        " native Vim features so don't bother learning them
        " Plug 'mattn/emmet-vim'

        " ---
        " Plug 'sessionman.vim'

        " ---
        " let g:ctrlp_working_path_mode = '0'
        " Plug 'kien/ctrlp.vim'

        " ---
        " Improvements to netrw. Use this, not NerdTree
        " Most useful commands:
        "   ~: Go home (is this better than :e ~ ?)
        "   .: Start vim command with current file at end
        "   !: Start ! command with current file at end
        "   -: Go up directory
        "   gh: Toggle hidden files
        " Plug 'tpope/vim-vinegar'

        " ---
        " Plug 'scratch.vim'

    " Text edit commands {{{2

        " ---
        " Align text
        " :Tab /pattern
        Plug 'godlygeek/tabular'

        " ---
        " Toggle comments in code
        " gc<motion>: Toggle command
        " gcc: Toggle line
        " gcu: Uncomment adjacent lines
        " gc: Text object
        " Plug 'tpope/vim-commentary'

        " ---
        Plug 'wojtekmach/vim-rename'

        " ---
        " let g:UltiSnipsExpandTrigger="<tab>"
        " let g:UltiSnipsJumpForwardTrigger="<tab>"
        " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        " Plug 'SirVer/ultisnips'


    " External Integration {{{2

        Plug 'pangloss/vim-javascript'
        Plug 'mxw/vim-jsx'
        Plug 'rafi/awesome-vim-colorschemes'
        Plug 'chriskempson/base16-vim'
        Plug 'bogado/file-line'

        " Plug '/usr/local/opt/fzf'
        " Plug 'junegunn/fzf.vim'
        Plug 'Shougo/vimproc.vim', {'do' : 'make'}
        Plug 'Shougo/neomru.vim'
        Plug 'Shougo/unite.vim'
        Plug 'ujihisa/unite-colorscheme'

        " My Unite
        nnoremap <leader>b :Unite -no-split -start-insert buffer <cr>
        nnoremap <leader>c :Unite -no-split -start-insert colorscheme <cr>

        " Unite
        let g:unite_source_history_yank_enable = 1
        " call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', 'node_modules')
        nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/git:--exclude-standard<cr>
        nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
        nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
        nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
        nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
        nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

        " Custom mappings for the unite buffer
        autocmd FileType unite call s:unite_settings()
        function! s:unite_settings()
        " Play nice with supertab
        " let b:SuperTabDisabled=1
        " Enable navigation with control-j and control-k in insert mode
        imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
        endfunction

        " ---
        " :Gcd, :Glcd - cd relative to repo
        " :Gstatus, :Gcommit, :Gmerge, :Gdiff, :Gmove...
        Plug 'tpope/vim-fugitive'

        " ---
        "  Disabled for now
        let g:gitgutter_enabled = 0
        Plug 'airblade/vim-gitgutter'

        " ---
        let g:neomake_javascript_enabled_makers = ['eslint']
        let g:neomake_jsx_enabled_makers = ['eslint']
        " let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
        " let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
        " let g:neomake_javascript_eslint_maker = {
                    " \ 'exe': b:neomake_javascript_eslint_exe }
        Plug 'neomake/neomake'
        " Plug 'benjie/neomake-local-eslint.vim'
        " Run on every buffer save and open
        autocmd! BufEnter,BufWritePost * Neomake

        " ---
        " :Ag and :Ack
        " Not sure this is needed given :grep and grepprg...
        " Plug 'rking/ag.vim'
        " Plug 'mileszs/ack.vim'

        " ---
        " Plug 'christoomey/vim-tmux-navigator'

    " Additional Filetype Support {{{2
        let g:jsx_ext_required = 0 " Allow JSX in normal JS files

        Plug 'tpope/vim-markdown'
        Plug 'tpope/vim-haml'
        Plug 'groenewege/vim-less'
        Plug 'sophacles/vim-bundle-mako'
        Plug 'Glench/Vim-Jinja2-Syntax'
        Plug 'wting/rust.vim'
        Plug 'vim-jp/vim-cpp'
        Plug 'lambdatoast/elm.vim'
        Plug 'mxw/vim-jsx'

        " Plug 'spwhitt/vim-nix'
        Plug 'file:///Users/swhitt/src/vim-nix'

        " let g:syntastic_javascript_checkers = ['eslint']

    " Other {{{2

        " ---
        "  My colorscheme choice
        " let g:solarized_visibility = "normal"
        " Original solarized
        "Plug 'altercation/vim-colors-solarized'
        " Solarized fork with better signcolumn colors
        " Plug 'jwhitley/vim-colors-solarized'

        " ---
        " Manage buffers. <leader>be to open
        " Plug 'bufexplorer.zip'

        " ---
        " m, - Toggle mark at current line (alphabetical order)
        " m_ - clear all marks in file
        " m] - jump to next local mark
        " m[ - jump to previous local mark
        " m? - open location list
        "
        " Vim builtin marks cheatsheet:
        "  m[a-zA-Z] - Set mark
        "  . - Last change to file
        "  [ - First char of previous yank or change
        "  ] - First char of previous yank or change
        "  < - First char of last visual area
        "  > - Last char of last visual area
        "  ' - Previous jump
        "  " - Position last exited current buffer
        "  ^ - Last exited insert mode
        " Plug 'jeetsukumaran/vim-markology'
    " }}}

    call plug#end()


" Appearance {{{1

    " make xml closing tag color match opening tag color
    " hi Tag        ctermfg=04
    " hi xmlTag     ctermfg=04
    " hi xmlTagName ctermfg=04
    " hi xmlEndTag  ctermfg=04

    " if has('gui_running')
    "     set background=dark

    "     " No extra gui crap in gvim
    "     set guioptions-=m
    "     set guioptions-=T
    "     set guioptions-=e
    "     set guioptions-=r
    "     set guioptions-=R
    "     set guioptions-=l
    "     set guioptions-=L
    " else
    "     set background=dark
    " endif

    colorscheme base16-oceanicnext

    set guifont=Sauce\ Code\ Powerline:h14

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

    " Number column no wider than it needs to be
    set numberwidth=1

    " Display line at 80 characters to remind me to break long lines
    set colorcolumn=81
    "let &colorcolumn=join(range(81,256),",")

    " Don't automatically wrap text. Color column is enough as a gentle reminder
    set textwidth=0

    " Nice autocomplete bar
    set wildignore=*.o,*~,*.pyc

    " Pretty invisibles
    "set listchars=tab:▸\ ,eol:¬
    "set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    "set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
    set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:±,trail:⋅
    set list

    " Indicate if a line is wrapped
    set showbreak=❯

    " Scroll screen 4 lines before cursor hits top/bottom
    set scrolloff=4
    set sidescrolloff=4

    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500

    " Properly disable sound on errors on MacVim
    if has("gui_macvim")
        autocmd GUIEnter * set vb t_vb=
    endif

" Behavior {{{1

    " Same split behavior as tmux
    set splitright
    set splitbelow

    set modeline

    " Put name of current file in titlebar
    set title

    " Tab character settings
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    " Insert spaces instead of tab character when tab key is pressed
    set expandtab
    " Round indent to multiple of shiftwidth when using > and <
    set shiftround

    " Line numbering disabled for a clean look
    set nonumber
    set norelativenumber

    " Ctags
    " set tags=tags;

    " Don't have to save buffers before switching to new ones
    " Disabled because I find it becomes difficult to managed modified, unsaved buffers
    " set hidden

    " Soft wrap
    " set linebreak

    " gq command formats with par
    " set formatprg=par\ -r

    " Don't redraw while executing macros (good performance config)
    set lazyredraw

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

    " Return to last edit position when opening files (You want this!)
    " autocmd BufReadPost *
    "             \ if line("'\"") > 0 && line("'\"") <= line("$") |
    "             \   exe "normal! g`\"" |
    "             \ endif

    " Remember open buffers on close
    " set viminfo^=%

    " Remember undo history
    if has("persistent_undo")
        " set undodir='$HOME/.vim/undo'
        " set undofile
    endif

" Key Bindings {{{1

    " ---
    " Minimal Vim
    "
    " Here I disable useless keys, so that I will not use them and can reclaim
    " them for other uses in the future

    " Ex mode is annoying and useless. Only masochists use it.
    nnoremap Q <nop>

    " Equivalent to cc
    nnoremap S <nop>
    xnoremap S <nop>

    " Equivalent to cl
    " nnoremap s <nop>
    xnoremap s <nop>

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

    "blah"
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
    " xnoremap gc gu~l

    " Trim trailing whitespace
    nnoremap <leader>tw :%s/\s\+$//<cr>``
    nmap <leader>ts <leader>tw

    "This allows for change paste motion cp{motion}
    nmap <silent> cp :set opfunc=ChangePaste<CR>g@
    function! ChangePaste(type, ...)
        silent exe "normal! `[v`]\"_c"
        silent exe "normal! p"
    endfunction

    " Enter key inserts a new line
    nnoremap <cr> o<esc>
    nnoremap <S-cr> O<esc>

    " Press q to quit macro mode
    " Press v to quit visual mode
    " Press V to quit visual line mode
    " Press C-v to quit visual block mode
    " Press jk to quit insert mode, `^ is so the cursor doesn't move
    inoremap <C-Space> <esc>`^
    xnoremap <C-Space> <esc>
    cnoremap <C-Space> <C-c>
    onoremap <C-Space> <esc>
    inoremap <C-Enter> <esc>`^
    xnoremap <C-Enter> <esc>
    cnoremap <C-Enter> <C-c>
    onoremap <C-Enter> <esc>
    " Neovim's terminal window
    tnoremap <C-Space> <C-\><C-n>
    tnoremap <esc> <C-\><C-n>

    " Force myself to switch from <esc> and <C-c> to the above scheme:
    " noremap <esc> <nop>
    " xnoremap <esc> <nop>
    " cnoremap <esc> <nop>
    " noremap <C-c> <nop>
    " xnoremap <C-c> <nop>
    " cnoremap <C-c> <nop>

    " Ctrl+c behaves different from esc in certain situations
    " eg: when making an edit from visual block mode
    " inoremap  <C-c>  <esc>
    " xnoremap  <C-c>  <esc>
    "cnoremap  <C-c>  <esc>

    " Only highlight first 200 cols
    set synmaxcol =200

    " Tab navigation
    noremap <S-H> gT
    noremap <S-L> gt
    noremap <leader>tn :tabedit<CR>
    noremap <leader>tc :tabclose<CR>

    " Switch windows with ctrl
    " noremap <C-j> <C-W>j
    " noremap <C-k> <C-W>k
    " noremap <C-h> <C-W>h
    " noremap <C-l> <C-W>l

    " Split control (and tabs)
    noremap sp :split<cr>
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
    noremap s= <C-W>=
    noremap s+ <C-W>_<C-W>\|
    noremap s<Left> :tabprev<cr>
    noremap s<Right> :tabnext<cr>

    inoremap <C-s>p :split<cr>

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
    noremap <silent> <esc> :nohlsearch<cr>

    " <Leader>cd: Switch to the directory of the open buffer
    nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

    " The * command should stay on the current word
    " nnoremap * *``


    " Easier word deletion in insert mode
    inoremap <C-BS> <C-w>

    " TODO: Move these with other navigational things
    nnoremap <leader>de :Explore<cr>


" Filetype Settings {{{1

    " Make is pretty crappy about tabs vs spaces
    autocmd FileType make setlocal noexpandtab
    " autocmd BufRead */TVS/* setlocal noexpandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2
    autocmd FileType haml setlocal ts=2 sts=2 sw=2
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2
    autocmd FileType haskell setlocal ts=2 sts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

    " Fix nanoc's yaml frontmatter syntax highlighting
    autocmd BufNewFile,BufRead *.md syntax match Comment /\%^---\_.\{-}---$/

    autocmd BufNewFile,BufRead *.j2 set syntax=jinja

    " Comment settings for cmake
    autocmd FileType cmake set commentstring=#\ %s

    " Open vimrc in a new tab
    " Mnemonic: Edit Vimrc
    nnoremap <leader>ev :e $MYVIMRC<CR>

    " Automatically source the vimrc file after saving it
    " autocmd! bufwritepost .vimrc source $MYVIMRC
    " autocmd! bufwritepost vimrc source $MYVIMRC

    augroup reload_vimrc
        autocmd!
        autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
    augroup END

