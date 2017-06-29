set nocompatible
" -- General Settings {{{
"tabs to spaces
set tabstop=4
set expandtab
set shiftwidth=4
"set <leader> to comma
let mapleader=','
set lazyredraw
set number
"silence error bells
set vb t_vb=
"allow using backspace in insert mode
set backspace=indent,eol,start
"don't break words when wrapping
set wrap
set linebreak
" -- }}}

" -- Color Settings {{{
syntax on
set background=dark
colorscheme iceberg
"when entering insert mode, change the statusline color to bright blue
augroup Statusline
    autocmd!
    autocmd InsertEnter * highlight StatusLine ctermfg=4 ctermbg=white
    autocmd InsertLeave * highlight StatusLine ctermfg=black ctermbg=white
augroup END
" -- }}}

" -- statusline Settings {{{
set statusline=%F
set statusline+=\ type:\ %y
set statusline+=%=
set statusline+=Line:\ %l\/%L
set statusline+=\ \ Column:\ %c
set laststatus=2
highlight StatusLine ctermfg=black ctermbg=white
" -- }}}

" -- FileType specific Settings {{{
filetype plugin on
augroup FileTypeGroup
    autocmd!
    " arduino and processing files have c++ syntax highlighting
    autocmd BufNewFile,BufReadPost *.ino,*.pde setlocal filetype=cpp 
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType cpp,c setlocal foldmethod=syntax
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType make setlocal noexpandtab
    autocmd FileType tex,plaintex setlocal makeprg=pdflatex\ % foldmethod=marker
    autocmd FileType java setlocal makeprg=javac\ %
    autocmd FileType java nmap <leader>r :!java %:r<CR>
augroup END
" -- }}}

" -- Normal mode mapping {{{
"better navigation of splits
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
"resize all the panes
nnoremap _ <c-w>-
nnoremap + <c-w>+
nnoremap < <c-w><
nnoremap > <c-w>>
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
"leader m calls the makeprg
nnoremap <leader>m :make<CR>
"leader s enters the shell
nnoremap <leader>s :sh<CR>
"leader then a dot toggles highlighted search terms and incsearch
nnoremap <leader>. :set hls! incsearch!<CR>
"hitting <leader>[b|d]c will run bc or dc on that line, echo the output
"and store into "c (calculator register)
nnoremap <leader>dc :let @c=system("dc -e '".getline('.')."'")<CR>:echom @c<CR>
nnoremap <leader>bc :let @c=system("echo ".getline('.')."\|bc")<CR>:echom @c<CR>
"hitting <leader>y will copy from default register to system clipboard. Note,
"this very much only works on macs. Also, <leader>p pastes from clipboard
if system('uname | xargs echo -n') ==? "Darwin"
    nnoremap <leader>y :call system('pbcopy', @")<CR>
    nnoremap <leader>p :let temp=@"<CR>:let @"=system('pbpaste')<CR>p:let @"=temp<CR>
endif
"<leader>/ clears whatevers in the / register. Useful for clearing hls
nnoremap <leader>/ :call setreg('/', [])<CR>:echo "cleared search register"<CR>
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

" -- Visual mode mapping {{{
"same calculator functions from normal mode, but now inline selection
vnoremap <leader>dc "cy:let @c=system("dc -e '".@c."'")<CR>:echom @c<CR>
vnoremap <leader>bc "cy:let @c=system("echo ".@c."\|bc")<CR>:echom @c<CR>
"note, the dc one works on multiple lines, bc does not
" -- }}}

" -- Tab autocompletion {{{
"In insert mode, hitting <TAB> while on a character autocompletes
function! Tab_Or_Complete() 		"use tab to autocomplete words
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction

:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:imap <S-Tab> <C-R>="\<C-P>"<CR>
if system('uname | xargs echo -n') ==? "Darwin"
    "hacky hacky mac thing, because it doesn't handle shift tab well
    :imap [Z <S-Tab>
endif
" -- }}}

"Joke remaps. Unless you actually want these
"I enterred these so I could freak out the kids behind me in class
"Switch to 1337 h4xxx0r mode
nnoremap <leader>h :%!xxd<CR>
"Switch to noob mode
nnoremap <leader>n :%!xxd -r<CR>

"Shifting entire lines up and down. Temp for now, if I like I'll keep
nnoremap <DOWN> :m +1<CR>
nnoremap <UP> :m -2<CR>
