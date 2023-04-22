" -----------------------------------------------------------------------------
" File: superNova.vim
" Description: Retro groove color scheme for Vim based on gruvbox
" Author: bvgross <bvgross@gmx.com>
" Source: https://github.com/bvgross/superNovaTheme
" Last Modified: 22 apr 2023
" -----------------------------------------------------------------------------

function! superNova#invert_signs_toggle()
  if g:superNova_invert_signs == 0
    let g:superNova_invert_signs=1
  else
    let g:superNova_invert_signs=0
  endif

  colorscheme superNova
endfunction

" Search Highlighting {{{

function! superNova#hls_show()
  set hlsearch
  call superNovaHlsShowCursor()
endfunction

function! superNova#hls_hide()
  set nohlsearch
  call superNovaHlsHideCursor()
endfunction

function! superNova#hls_toggle()
  if &hlsearch
    call superNova#hls_hide()
  else
    call superNova#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
