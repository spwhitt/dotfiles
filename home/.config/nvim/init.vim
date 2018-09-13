" vim: expandtab foldmethod=marker
"
" File: .vimrc
" Author: Spencer Whitt
"
" Leader: A key often used to prefix custom commands. Even if you don't use it,
" plugins will. Many people recommend using ',' as leader. I disagree, because
" ',' is a useful key

" If there is a .nvimrc or .exrc in the current directory, read it (securely)
" Enables project-specific configuration
" set exrc
" set secure

" set t_Co=256
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
nnoremap <silent> <leader>h :Help

call plug#begin('~/.local/share/nvim/plugged')

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

Plug 'jeetsukumaran/vim-indentwise'

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
" ai, ii, aI, iI: an indentation level
Plug 'kana/vim-textobj-indent'

" ---
" Lightweight improvements to status bar

" Don't show mode below the status line, airline handles this for us
set noshowmode

" " Turn this on to use powerline symbols
" let g:airline_powerline_fonts=0

" " Disable sep symbols. Takes less space, doesn't require weird fonts, etc.
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Use short mode text to save space
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

" Don't bother displaying file encoding if it's utf-8[unix]
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" " Required in order to make the below tweaks
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.modified = '%'

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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --
" Display visual indication of current indent level
Plug 'Yggdroot/indentLine'

" --
" Replacement for netrw
let g:vimfiler_as_default_explorer = 1
Plug 'Shougo/vimfiler.vim'

" Text edit commands {{{2

    " ---
    " Align text
    " :Tab /pattern
    Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

    " ---
    " Toggle comments in code
    " gc<motion>: Toggle command
    " gcc: Toggle line
    " gcu: Uncomment adjacent lines
    " gc: Text object
    Plug 'tpope/vim-commentary'

    " ---
    Plug 'wojtekmach/vim-rename', { 'on': 'Rename' }

" External Integration {{{2

  Plug 'let-def/vimbufsync'
  Plug 'trefis/coquille'
  " Plug 'jvoorhis/coq.vim'
  " Plug 'vim-scripts/CoqIDE'

    " Colorschemes
    " Plug 'rafi/awesome-vim-colorschemes'
    Plug 'mhartington/oceanic-next'
    " Plug 'chriskempson/base16-vim'

    " Open file with line number
    Plug 'bogado/file-line'

    " Unite, its dependencies, and additional sources
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/unite.vim'
    Plug 'ujihisa/unite-colorscheme'

    " My Unite
    nnoremap <leader>b :Unite -no-split -start-insert buffer <cr>
    nnoremap <leader>c :Unite -no-split -start-insert colorscheme <cr>
    nnoremap <leader>p :Unite -no-split register <cr>

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
    augroup unite_buffer_settings
        autocmd!
        autocmd FileType unite call s:unite_settings()
        function! s:unite_settings()
        " Play nice with supertab
        " let b:SuperTabDisabled=1
        " Enable navigation with control-j and control-k in insert mode
        imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
        endfunction
    augroup END

    " ---
    " :Gcd, :Glcd - cd relative to repo
    " :Gstatus, :Gcommit, :Gmerge, :Gdiff, :Gmove...
    Plug 'tpope/vim-fugitive'

    " ---
    "  Disabled for now
    " let g:gitgutter_enabled = 0
    " Plug 'airblade/vim-gitgutter'

    " ---
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_jsx_enabled_makers = ['eslint']

    " let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
    " let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
    " Plug 'benjie/neomake-local-eslint.vim'
    Plug 'neomake/neomake'

    " Run on every buffer save and open
    augroup neomake_auto_run
        autocmd!
        autocmd BufEnter,BufWritePost * Neomake
    augroup END

    " ---
    " :Ag and :Ack
    Plug 'rking/ag.vim', { 'on': 'Ag' }
    Plug 'mileszs/ack.vim', { 'on': 'Ack' }

" Additional Filetype Support {{{2
"
    " Syntax Plugins
    let g:jsx_ext_required = 0 " Allow JSX in normal JS files
    Plug 'derekelkins/agda-vim'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'tpope/vim-markdown'
    Plug 'tpope/vim-haml'
    Plug 'groenewege/vim-less'
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug 'wting/rust.vim'
    Plug 'vim-jp/vim-cpp'
    Plug 'lambdatoast/elm.vim'
    Plug 'keith/swift.vim'

call plug#end()


" Appearance {{{1

    " make xml closing tag color match opening tag color
    " hi Tag        ctermfg=04
    " hi xmlTag     ctermfg=04
    " hi xmlTagName ctermfg=04
    " hi xmlEndTag  ctermfg=04

    if (has("termguicolors"))
      set termguicolors
    endif

    " Theme
    colorscheme OceanicNext

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

    " Don't automatically wrap text. Color column is enough as a gentle reminder
    set textwidth=0

    " Things to ignore from wildmenu completion
    set wildignore=*.o,*~,*.pyc

    " Pretty invisibles
    "set listchars=tab:▸\ ,eol:¬
    "set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
    "set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
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
    set tm=500

    " Properly disable sound on errors on MacVim
    if has("gui_macvim")
        augroup macvim_vb
            autocmd!
            autocmd GUIEnter * set vb t_vb=
        augroup END
    endif

    " Behavior {{{1

    " Same split behavior as tmux
    set nosplitright
    set nosplitbelow

    set modeline

    " Put name of current file in titlebar
    set title

    " Disable softtabstop and shiftwidth, so that tabstop is the only setting
    " Tab settings in Vim are crazy... and this make it simple like it should be
    set softtabstop=0
    set shiftwidth=0

    " Round indent to multiple of shiftwidth when using > and <
    " This is nice to make < and > fix the indentation level
    set shiftround

    " Default: Use 2 spaces for tabs
    set expandtab
    set tabstop=2

    " Line numbering disabled for a clean look
    set nonumber
    set norelativenumber

    " Don't have to save buffers before switching to new ones
    " This is important for this vimrc's intended workflow to work well:
    " e.g. opening a Unite buffer momentarily in the current window
    set hidden

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

    " Don't move cursor on visual yank
    " Less unexpected cursor movements and side effects = better
    vnoremap <expr>y "my\"" . v:register . "y`y"

    " Return to last edit position when opening files
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

    " Equivalent to cl
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
      silent exe "normal! `[v`]\"_c"
      silent exe "normal! p"
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
    tnoremap <esc> <C-\><C-n>

    " Only highlight first 200 cols (performance)
    set synmaxcol =200

    " Tab navigation
    noremap <S-H> gT
    noremap <S-L> gt

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
    " nnoremap - za

    " Time based history navigation
    nnoremap - g-
    nnoremap + g+


    " Make Y behave like everyone else
    nnoremap Y y$

    " g0 does what 0 used to
    nnoremap 0 ^

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
    augroup filetype_settings
        autocmd!
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
    augroup END

    " Open vimrc in a new tab
    " Mnemonic: Edit Vimrc
    nnoremap <leader>ev :e $MYVIMRC<CR>

    " Automatically source the vimrc file after saving it
    augroup reload_vimrc
        autocmd!
        autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
    augroup END
