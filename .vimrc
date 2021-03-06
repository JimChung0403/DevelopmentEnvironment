set encoding=utf-8
set fileencodings=utf-8,cp950
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ai
set ruler
set nu
set hlsearch
set smartindent
set cursorline
set cursorcolumn
"set paste
set background=dark
syntax on
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
command -bar Hexmode call ToggleHex()



function! ToggleHex()
   " hex mode should be considered a read-only operation
   " save values for modified and read-only for restoration later,
   " and clear the read-only flag for now
   let l:modified=&mod
   let l:oldreadonly=&readonly
   let &readonly=0
   let l:oldmodifiable=&modifiable
   let &modifiable=1
   if !exists("b:editHex") || !b:editHex
       " save old options
       let b:oldft=&ft
       let b:oldbin=&bin
       " set new options
       setlocal binary " make sure it overrides any textwidth, etc.
       let &ft="xxd"
       " set status
       let b:editHex=1
       " switch to hex editor
       %!xxd
   else
       " restore old options
       let &ft=b:oldft
       if !b:oldbin
           setlocal nobinary
       endif
       " set status
       let b:editHex=0
       " return to normal editing
       %!xxd -r
   endif
   " restore values for modified and read only state
   let &mod=l:modified
   let &readonly=l:oldreadonly
   let &modifiable=l:oldmodifiable
endfunction
