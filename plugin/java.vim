"leader m to compile, leader r to run
setlocal makeprg=javac\ %
nmap <leader>r :!java %:r<CR>

"In java, we fold via syntax, because why not
setlocal foldmethod=syntax

"let it do a bunch of ide-style autoindentation that's
"guaranteed to make you hate yourself
setlocal smartindent
