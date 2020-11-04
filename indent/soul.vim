" Vim indent file
" Language: SOUL
" Maintainer: Griffin Moe <me@griffin.moe>

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" C++ indenting is built-in, and SOUL is very close to C++
setlocal cindent

let b:undo_indent = "setl cin<"
