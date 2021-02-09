" Quit when a syntax file was already loaded.
if exists('b:current_syntax')
  finish
endif

" Tell Vim to start redrawing by rescanning all previous text. This isn't
" exactly optimal for performance but it enables accurate syntax highlighting.
" Ideally we'd find a way to get accurate syntax highlighting without the
" nasty performance implications, but for now I'll accept the performance
" impact in order to have accurate highlighting. For more discussion please
" refer to https://github.com/xolox/vim-notes/issues/2.
syntax sync fromstart

highlight TODO  ctermfg=Grey guifg=Grey


syntax match TODO "TODO"
syntax match DONE "DONE"
highlight TODO guifg=#CC8811 gui=bold
highlight DONE guifg=#88CC11 gui=bold


syn match    customHeader1     "^#\{1\}.*"
syn match    customHeader2     "^#\{2\}.*"
syn match    customHeader3     "^#\{3\}.*"
syn match    customHeader4     "^#\{4\}.*"
syn match    customHeader5     "^#\{5\}.*"

highlight customHeader5 guifg=#FF7B00 gui=bold
highlight customHeader2 guifg=#FF9500 gui=bold
highlight customHeader4 guifg=#FFAA00 gui=bold
highlight customHeader3 guifg=#FFC300 gui=bold
highlight customHeader1 guifg=#FFEA00 gui=bold

