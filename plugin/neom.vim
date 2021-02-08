
" The VimL/VimScript code is included in this sample plugin to demonstrate the
" two different approaches but it is not required you use VimL. Feel free to
" delete this code and proceed without it.

echo "Starting the example Python Plugin"

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

setlocal foldmethod=expr
setlocal foldexpr=NeomGetFold(v:lnum)

syn match    customHeader1     "^# "
syn match    customHeader2     "^## "
syn match    customHeader3     "^### "
syn match    customHeader4     "^#### "
syn match    customHeader5     "^##### "

highlight customHeader1 ctermfg=34
highlight customHeader2 ctermfg=32
highlight customHeader3 ctermfg=127
highlight customHeader4 ctermfg=45
highlight customHeader5 ctermfg=220


" the rest of plugin VimL code goes here

let g:neom_plugin_loaded = 1
