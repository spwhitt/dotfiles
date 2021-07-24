" I prefer standard line comments
setlocal commentstring=;;\ %s
" Indent properly after this word
setlocal lispwords+=define/contract
" Compiling isn't so useful in racket. Unit testing is.
compiler racotest

" Could set equalprg to scmindent here
" https://github.com/ds26gte/scmindent
