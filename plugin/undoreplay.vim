"=============================================================================
" FILE: plugin/undoreplay.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_undoreplay
endif
if exists('g:loaded_undoreplay')
  finish
endif
let g:loaded_undoreplay = 1
let s:save_cpo = &cpo
set cpo&vim

command! UndoReplay call undoreplay#replay()

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
