
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

" setlocal foldmethod=expr
" setlocal foldexpr=NeomGetFold(v:lnum)

" setlocal foldmethod=expr
" " let Func = function('NNeomGetFold')
" setlocal foldexpr=NNeomGetFold(v:lnum)
"
" function! NNeomGetFold(lnum)
"   return NeomGetFold(4)
" endfunction
"
" the rest of plugin VimL code goes here

let g:neom_plugin_loaded = 1

au BufRead,BufNewFile *.md set filetype=neom
