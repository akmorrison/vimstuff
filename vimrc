" -- General Settings {{{
"tabs to spaces
set tabstop=4
set expandtab
"set <leader> to comma
let mapleader=','
set lazyredraw
set number
"silence error bells
set vb t_vb=
"allow using backspace in insert mode
set backspace=indent,eol,start
" -- }}}

" -- Color Settings {{{
syntax on
set background=dark
colorscheme iceberg
" -- }}}

" -- statusline Settings {{{
set statusline=%F
set statusline+=\ type:\ %y
set statusline+=%=
set statusline+=Line:\ %l
set statusline+=\ \ Column:\ %c
set laststatus=2
highlight StatusLine ctermfg=black ctermbg=white
" -- }}}

" -- FileType specific Settings {{{
augroup FileTypeGroup
    autocmd!
    " arduino and processing files have c++ syntax highlighting
    autocmd BufNewFile,BufReadPost *.ino,*.pde setlocal filetype=cpp 
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType cpp,c setlocal foldmethod=syntax
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType make setlocal noexpandtab
augroup END
" -- }}}

" -- Normal mode mapping {{{
"better navigation of splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
"better navigation of tabs.
nnoremap <c-p> :tabnext<CR>
nnoremap <c-u> :tabprevious<CR>
nnoremap <c-n> :tabnew<CR>
"delete a line, and replace with most recently yanked line
nnoremap dp ddk"0p
"allows editing and sourcing of vimrc file
nnoremap <leader>ve :vsp $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
"better saving and quitting
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
"edit files with leader command
nnoremap <leader>e :e 
" -- }}}

" -- Insert mode mapping {{{
"get out of insert mode faster
inoremap jj <esc>
"what for not letting me out of insert mode slowly
inoremap <esc> <nop>
"disallow navigating by arrowkeys
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <up> <nop>
" -- }}}
