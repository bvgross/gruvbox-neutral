" -----------------------------------------------------------------------------
" File: gruvbox-neutral.vim
" Description: Retro groove color scheme for Vim based on gruvbox
" Author: bvgross <bvgross@gmx.com>
" Source: https://github.com/bvgross/gruvbox-neutral
" Last Modified: 08 jul 2022
" -----------------------------------------------------------------------------

function! gruvboxNeutral#invert_signs_toggle()
  if g:gruvboxNeutral_invert_signs == 0
    let g:gruvboxNeutral_invert_signs=1
  else
    let g:gruvboxNeutral_invert_signs=0
  endif

  colorscheme gruvboxNeutral
endfunction

" Search Highlighting {{{

function! gruvboxNeutral#hls_show()
  set hlsearch
  call gruvboxNeutralHlsShowCursor()
endfunction

function! gruvboxNeutral#hls_hide()
  set nohlsearch
  call gruvboxNeutralHlsHideCursor()
endfunction

function! gruvboxNeutral#hls_toggle()
  if &hlsearch
    call gruvboxNeutral#hls_hide()
  else
    call gruvboxNeutral#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
