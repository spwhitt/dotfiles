" My customizations to The Ultimate vimrc (https://github.com/amix/vimrc)

colorscheme default

nnoremap <SPACE> <Nop>

" Too lazy to hold shift
nnoremap ; :

" Easier tab navigation
map <S-H> gT
map <S-L> gt

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Change vimrc edit binding
map <leader>e <Nop>
map <leader>v :e! ~/.vim_runtime/my_configs.vim<cr>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Save the Esc key
imap jk <Esc>
cmap jk <ESC>
vmap jk <ESC>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" No menu bar
set guioptions-=m

" Modelines are nice
set modeline
set modelines=1
