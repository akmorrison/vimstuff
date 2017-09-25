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
    autocmd InsertEnter * highlight StatusLine ctermfg=white ctermbg=4
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
highlight StatusLine ctermfg=black ctermbg=white cterm=italic
highlight StatusLineNC ctermfg=white ctermbg=black cterm=italic
" -- }}}

" -- FileType specific Settings {{{
filetype plugin on "I've slowly been moving these to their own plugin files
augroup FileTypeGroup
    autocmd!
    " arduino and processing files have c++ syntax highlighting
    autocmd BufNewFile,BufReadPost *.ino,*.pde setlocal filetype=cpp 
augroup END
" -- }}}

" -- Normal mode mapping {{{
function! Map_Normal_Things()
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
    "hitting space redraws the screen with the current line in the center
    nnoremap <space> zz
    "Shifting entire lines up and down. Temp for now, if I like I'll keep
    nnoremap <down> :m +1<cr>
    nnoremap <up> :m -2<cr>
    "right arrow should jump to the next mispelled word. Left arrow should go to the last one
    nnoremap <right> ]s
    nnoremap <left> [s
    "used to populate or depopulate the search register
    nnoremap <leader>/ :call Handle_Search_Reg( 0 )<CR>
endfunction
function! Unmap_Normal_Things()
    nunmap <c-h>
    nunmap <c-j>
    nunmap <c-k>
    nunmap <c-l>
    nunmap _
    nunmap +
    nunmap <
    nunmap >
    nunmap <c-p>
    nunmap <c-u>
    nunmap <c-n>
    nunmap dp
    nunmap <leader>ve
    nunmap <leader>vs
    nunmap <leader>w
    nunmap <leader>q
    nunmap <leader>e
    nunmap <leader>m
    nunmap <leader>s
    nunmap <leader>.
    nunmap <leader>dc
    nunmap <leader>bc
    if system('uname | xargs echo -n') ==? "Darwin"
        nunmap <leader>y
        nunmap <leader>p
    endif
    nunmap <space>
    nunmap <down>
    nunmap <up>
    nunmap <right>
    nunmap <left>
    nunmap <leader>/
endfunction
" -- }}}

" -- Insert mode mapping {{{
function! Map_Insert_Things()
    "get out of insert mode faster
    inoremap jj <esc>
    inoremap jf <esc>
    "disallow navigating by arrowkeys
    inoremap <left> <nop>
    inoremap <right> <nop>
    inoremap <down> <nop>
    inoremap <up> <nop>
    inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
    imap <S-Tab> <C-R>="\<C-P>"<CR>
    if system('uname | xargs echo -n') ==? "Darwin"
        "hacky hacky mac thing, because it doesn't handle shift tab well
        imap [Z <S-Tab>
    endif
endfunction
function! Unmap_Insert_Things()
    iunmap jj
    iunmap jf
    iunmap <left>
    iunmap <right>
    iunmap <down>
    iunmap <up>
    iunmap <Tab>
    iunmap <S-Tab>
    if system('uname | xargs echo -n') ==? "Darwin"
        "hacky hacky mac thing, because it doesn't handle shift tab well
        iunmap [Z <S-Tab>
    endif
endfunction
" -- }}}

" -- Visual mode mapping {{{
"same calculator functions from normal mode, but now inline selection
function! Map_Visual_Things()
    vnoremap <leader>dc "cy:let @c=system("dc -e '".@c."'")<CR>:echom @c<CR>
    vnoremap <leader>bc "cy:let @c=system("echo ".@c."\|bc")<CR>:echom @c<CR>
    "used to populate or depopulate the search register
    vnoremap <leader>/ :call Handle_Search_Reg( 1 )<CR>
endfunction
function! Unmap_Visual_Things()
    vunmap <leader>dc
    vunmap <leader>bc
    vunmap <leader>/
endfunction
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
" -- }}}

" -- Clear or populate search register on <leader>/ {{{
function! Handle_Search_Reg( visual )
    if a:visual
        set hls is
        normal! gv"zy
        echo "put \"" . @z . "\" in the search register"
        let @/ = @z
    else
        if @/==""
            set hls is
            normal! mz"zyiw`z
            echo "put \"" . @z . "\" in the search register"
            let @/ = @z
        else
            call setreg('/', [])
            echo "cleared search register"
        endif
    endif
    call setreg('z', [])
endfunction
"  -- }}}

" -- Apply and unapply all my mappings with one mapping {{{
function! Map_Everything()
    call Map_Normal_Things()
    call Map_Insert_Things()
    call Map_Visual_Things()
    echo "Applied all the mappings"
endfunction
function! Unmap_Everything()
    call Unmap_Normal_Things()
    call Unmap_Insert_Things()
    call Unmap_Visual_Things()
    echo "Removed all the mappings"
endfunction

nnoremap <leader>vm :call Map_Everything()<CR>
nnoremap <leader>vu :call Unmap_Everything()<CR>
" On startup, apply everything
" can't do this with Map_Everything, because that prints a thing
call Map_Normal_Things()
call Map_Insert_Things()
call Map_Visual_Things()

" Let's do a cool thing where <leader><leader> toggles whether your mappings are
" applied or not
function! Toggle_Everything()
	if mapcheck("<c-j>", "N") == ""
		call Map_Everything()
	else
        call Unmap_Everything()
	endif
endfunction
nnoremap <leader><leader> :call Toggle_Everything()<CR>

" -- }}}
