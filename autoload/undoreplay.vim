"=============================================================================
" FILE: autoload/undoreplay.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

function! undoreplay#replay() abort
  call s:replay(undotree(), 300)
endfunction

function! s:replay(undotree, interval) abort
  if a:undotree.seq_cur is# 0
    echo 'No undotree'
    return
  endif
  let orig_view = winsaveview()
  let scrolloff_save = &scrolloff
  let &scrolloff = max([10, &scrolloff])
  try
    call s:replay_entries(s:flatten_entries(a:undotree.entries), a:interval)
  finally
    let &scrolloff = scrolloff_save
    call s:undo(a:undotree.seq_cur)
    call winrestview(orig_view)
    echo ''
  endtry
endfunction

function! s:replay_entries(entries, t, ...) abort
  let rt = get(a:, 1, reltime())
  let t = a:t
  let len = len(a:entries)
  let idx = 0
  let is_stop = 0
  while idx < len
    let entry = a:entries[idx]
    let seq = entry.seq
    let chr = getchar(0)
    if s:is_char(chr, "\<Down>")
      let t += 50
    elseif s:is_char(chr, "\<Up>")
      let t = max([1, t - 50])
    elseif s:is_char(chr, "\<Left>")
      let idx = max([0, idx - 1])
      let is_stop = 1
    elseif s:is_char(chr, "\<Right>")
      let idx = min([len - 1, idx + 1])
      let is_stop = 1
    elseif s:is_char(chr, "\<Space>")
      let is_stop = 1 - is_stop
    elseif s:is_char(chr, '?')
      call s:show_usage()
    elseif chr
      break
    endif
    call s:update(seq, idx, len, entry.time)
    if !is_stop
      call s:sleep(t, rt)
      let rt = reltime()
      let idx += 1
    endif
  endwhile
endfunction

function! s:update(seq, idx, len, time) abort
  call s:undo(a:seq)
  echo s:build_progressbar(a:idx, a:len, a:time)
  redraw
endfunction

function! s:build_progressbar(idx, len, time) abort
  let persent = str2float(a:idx) / str2float(a:len)
  let timestr = strftime('%Y %b %d %X', a:time)
  let width = max([0, &columns - (10 + strdisplaywidth(timestr))])
  let progress = float2nr(persent * width)
  let rest = width - progress
  return printf('%s, %3d%% [%s%s]', timestr, float2nr(persent * 100), repeat('#', progress), repeat(' ', rest))
endfunction

function! s:flatten_entries(entries) abort
  let es = []
  for entry in a:entries
    if has_key(entry, 'alt')
      let es += s:flatten_entries(entry.alt)
    endif
    let es += [entry]
  endfor
  return es
endfunction

function! s:sleep(time, before) abort
  let ds = float2nr(a:time - str2float(reltimestr(reltime(a:before))) * 1000.0)
  if ds > 0
    execute 'sleep' printf('%sm', ds)
  endif
endfunction

function! s:is_char(char, target) abort
  return a:char is# a:target ? 1 : a:char is# char2nr(a:target)
endfunction

function! s:undo(seq) abort
  silent execute ':undo' a:seq
endfunction

function! s:usage() abort
  return join([
  \   ' HELP',
  \   ' ====',
  \   ' | Keymap  | Details             | ',
  \   ' | ------- | ------------------- | ',
  \   ' | <Up>    | Speed up            | ',
  \   ' | <Down>  | Speed down          | ',
  \   ' | <Space> | stop/restart replay | ',
  \   ' | <Right> | next step           | ',
  \   ' | <Left>  | previous step       | ',
  \   ' | ?       | show help           | '
  \ ], "\n")
endfunction

function! s:show_usage() abort
  echo s:usage()
  while !getchar(0)
  endwhile
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
