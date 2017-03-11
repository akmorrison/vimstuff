" -- Color Settings {{{
syntax on
set background=dark
" -- }}}

" -- statusline Settings {{{
set statusline=%F
set statusline+=\ type:\ %y
set statusline+=%=
set statusline+=Line:\ %l
set statusline+=\ \ Column:\ %c
set laststatus=2
hi Statusline ctermfg=black ctermbg=green
" -- }}}

" -- FileType specific Settings {{{
augroup FileTypeGroup
    autocmd!
    autocmd BufNewFile,BufReadPost *.ino,*.pde setlocal filetype=cpp " arduino and processing files have c++ syntax highlighting
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
"delete a line, and replace with most recently yanked line
nnoremap dp ddk"0p
"allows editing and sourcing of vimrc file
nnoremap <leader>ve :vsp $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>
"better saving
nnoremap <leader>w :w<CR>
" -- }}}

" -- Insert mode mapping {{{
"get out of insert mode faster
inoremap jj <esc>
"disallow navigating by arrowkeys
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <up> <nop>
" -- }}}

" -- General Settings {{{
"tabs to spaces
set tabstop=4
set expandtab
let mapleader=','
set lazyredraw
" -- }}}


