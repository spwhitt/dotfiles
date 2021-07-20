" Compiler file for raco test

if exists('current_compiler')
  finish
endif
let current_compiler = 'raco'

if exists(':CompilerSet') != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions-=C

CompilerSet makeprg=raco\ test

setlocal makeprg=raco\ test\ %

"""" Standard Testcase Failures """"
" Sample:
" --------------------
" unify
" FAILURE
" name:       check-equal?
" location:   mKanren-test.rkt:25:0
" actual:     #<procedure:var?>
" expected:   '(a . b)
" --------------------
" Start when we see "FAILURE"
CompilerSet errorformat=%EFAILURE
" Get file and location
CompilerSet errorformat+=%Clocation:\\s%#%f:%l:%c
" Extract message - operator, actual, expected
CompilerSet errorformat+=%C%.%#:%m
" End when we hit a ----
CompilerSet errorformat+=%Z-%#
" discard x test failures lines
CompilerSet errorformat+=%-G%.%#test\ failures
" discard lines which are just ----
CompilerSet errorformat+=%-G-%#

"""" Exceptions (and other errors?) """"
"""" Format:     at: somefile:23.32
CompilerSet errorformat+=\\s%#at:\ %f:%l.%c

"""" General File Format """"
CompilerSet errorformat+=\\s%#%f:%l:%c

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
