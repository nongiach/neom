
" The VimL/VimScript code is included in this sample plugin to demonstrate the
" two different approaches but it is not required you use VimL. Feel free to
" delete this code and proceed without it.

if !has("python3")
    echo "vim has to be compiled with +python3 to run this"
    finish
endif

if exists('g:neom_plugin_loaded')
    finish
endif

function DoItVimL()
    echo "hello from DoItVimL"
endfunction

" inoremap # #<esc>:exec DoItPython()
"
inoremap # #<esc>:call UpdateCurrentTitleLevel()<CR>
nmap gi :call NeomInsertNoteLink()<CR>
" nmap gn :echo expand("vs /home/cc/github/notes/<cWORD>")<CR>
nnoremap gn :execute 'vs /home/cc/github/notes/' . expand("<cWORD>")<CR>
" nnoremap gn execute "e tata"

" setlocal foldmethod=expr
" setlocal foldexpr=NNeomGetFold(v:lnum)

" setlocal foldmethod=expr
" " let Func = function('NNeomGetFold')
" setlocal foldexpr=NNeomGetFold(v:lnum)
"
function! NNeomGetFold(lnum)
  return NeomGetFold(4)
endfunction

" the rest of plugin VimL code goes here

let g:neom_plugin_loaded = 1

au BufRead,BufNewFile *.md set filetype=neom

" function! MarkdownFolds()
"   let thisline = getline(v:lnum)
"   if thisline =~? '\v^\s*$'
"       return '-1'
"   endif
"   if match(thisline, '^##') >= 0
"     return ">2"
"   elseif match(thisline, '^#') >= 0
"     return ">1"
"   else
"     return "="
"   endif
" endfunction
" setlocal foldmethod=expr
" setlocal foldexpr=MarkdownFolds()

" function! MarkdownFoldText()
"   let foldsize = (v:foldend-v:foldstart)
"   return getline(v:foldstart).' ('.foldsize.' lines)'
" endfunction
" setlocal foldtext=MarkdownFoldText()

function! InitNeom()
  set foldmethod=expr
  setlocal foldexpr=NeomGetFold(v:lnum)

  " highlight code snipet in note : starting with `
  syntax include @PY syntax/python.vim
  syntax region pySnip matchgroup=Snip start="`" end="\n\n" contains=@PY
  syntax region pySnip matchgroup=Snip start="`+" end="\n\n\n" contains=@PY

  " highlight console output : starting with ``
  syn match console ".*" contained
  syntax region consoleSnip matchgroup=Snip start="``" end="\n\n" contains=console
  syntax region consoleSnip matchgroup=Snip start="``+" end="\n\n\n" contains=console

  " syn region global_variables start="\(\*\*\*VARS\*\*\*\)\@<=" end="\(\*\*\*OTHERS
        " \*\*\*\)\@=" contains=global_var_match
  " hi link console ErrorMsg
  highlight console guifg=#CCCCCC guibg=#111111
endfunction
" let g:Func = function('NeomGetFold')
" setlocal foldexpr=g:Func(v:lnum)
"ant http link
au BufRead,BufNewFile *.md call InitNeom()

