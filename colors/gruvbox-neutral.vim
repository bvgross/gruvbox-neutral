" -----------------------------------------------------------------------------
" File: gruvbox-neutral.vim
" Description: Retro groove color scheme for Vim based on gruvbox
" Author: bvgross <bvgross@gmx.com>
" Source: https://github.com/bvgross/gruvbox-neutral
" Last Modified: 08 jul 2022
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='gruvbox-neutral'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:gruvboxNeutral_bold')
  let g:gruvboxNeutral_bold=1
endif
if !exists('g:gruvboxNeutral_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvboxNeutral_italic=1
  else
    let g:gruvboxNeutral_italic=0
  endif
endif
if !exists('g:gruvboxNeutral_undercurl')
  let g:gruvboxNeutral_undercurl=1
endif
if !exists('g:gruvboxNeutral_underline')
  let g:gruvboxNeutral_underline=1
endif
if !exists('g:gruvboxNeutral_inverse')
  let g:gruvboxNeutral_inverse=1
endif

if !exists('g:gruvboxNeutral_guisp_fallback') || index(['fg', 'bg'], g:gruvboxNeutral_guisp_fallback) == -1
  let g:gruvboxNeutral_guisp_fallback='NONE'
endif

if !exists('g:gruvboxNeutral_improved_strings')
  let g:gruvboxNeutral_improved_strings=0
endif

if !exists('g:gruvboxNeutral_improved_warnings')
  let g:gruvboxNeutral_improved_warnings=0
endif

if !exists('g:gruvboxNeutral_termcolors')
  let g:gruvboxNeutral_termcolors=256
endif

if !exists('g:gruvboxNeutral_invert_indent_guides')
  let g:gruvboxNeutral_invert_indent_guides=0
endif

if exists('g:gruvboxNeutral_contrast')
  echo 'g:gruvboxNeutral_contrast is deprecated; use g:gruvboxNeutral_contrast_light and g:gruvboxNeutral_contrast_dark instead'
endif

if !exists('g:gruvboxNeutral_contrast_dark')
  let g:gruvboxNeutral_contrast_dark='medium'
endif

if !exists('g:gruvboxNeutral_contrast_light')
  let g:gruvboxNeutral_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#313131', 236]     " 50-48-47
let s:gb.dark1       = ['#393939', 237]     " 60-56-54
let s:gb.dark2       = ['#4b4b4b', 239]     " 80-73-69
let s:gb.dark3       = ['#5d5d5d', 241]     " 102-92-84
let s:gb.dark4       = ['#707070', 243]     " 124-111-100
let s:gb.dark4_256   = ['#707070', 243]     " 124-111-100

let s:gb.gray_245    = ['#838383', 245]     " 146-131-116
let s:gb.gray_244    = ['#838383', 244]     " 146-131-116

let s:gb.light0_hard = ['#f0f0f0', 230]     " 249-245-215
let s:gb.light0      = ['#e1e1e1', 229]     " 253-244-193
let s:gb.light0_soft = ['#d6d6d6', 228]     " 242-229-188
let s:gb.light1      = ['#cfcfcf', 223]     " 235-219-178
let s:gb.light2      = ['#bbbbbb', 250]     " 213-196-161
let s:gb.light3      = ['#a8a8a8', 248]     " 189-174-147
let s:gb.light4      = ['#969696', 246]     " 168-153-132
let s:gb.light4_256  = ['#969696', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:gruvboxNeutral_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvboxNeutral_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvboxNeutral_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvboxNeutral_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvboxNeutral_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:gruvboxNeutral_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:gruvboxNeutral_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:gruvboxNeutral_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:gruvboxNeutral_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvboxNeutral_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:gruvboxNeutral_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvboxNeutral_hls_cursor)
endif

let s:number_column = s:none
if exists('g:gruvboxNeutral_number_column')
  let s:number_column = get(s:gb, g:gruvboxNeutral_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvboxNeutral_sign_column')
    let s:sign_column = get(s:gb, g:gruvboxNeutral_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:gruvboxNeutral_color_column')
  let s:color_column = get(s:gb, g:gruvboxNeutral_color_column)
endif

let s:vert_split = s:bg0
if exists('g:gruvboxNeutral_vert_split')
  let s:vert_split = get(s:gb, g:gruvboxNeutral_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvboxNeutral_invert_signs')
  if g:gruvboxNeutral_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvboxNeutral_invert_selection')
  if g:gruvboxNeutral_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvboxNeutral_invert_tabline')
  if g:gruvboxNeutral_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:gruvboxNeutral_italicize_comments')
  if g:gruvboxNeutral_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvboxNeutral_italicize_strings')
  if g:gruvboxNeutral_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvboxNeutral_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvboxNeutral_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" gruvboxNeutral Hi Groups: {{{

" memoize common hi groups
call s:HL('gruvboxNeutralFg0', s:fg0)
call s:HL('gruvboxNeutralFg1', s:fg1)
call s:HL('gruvboxNeutralFg2', s:fg2)
call s:HL('gruvboxNeutralFg3', s:fg3)
call s:HL('gruvboxNeutralFg4', s:fg4)
call s:HL('gruvboxNeutralGray', s:gray)
call s:HL('gruvboxNeutralBg0', s:bg0)
call s:HL('gruvboxNeutralBg1', s:bg1)
call s:HL('gruvboxNeutralBg2', s:bg2)
call s:HL('gruvboxNeutralBg3', s:bg3)
call s:HL('gruvboxNeutralBg4', s:bg4)

call s:HL('gruvboxNeutralRed', s:red)
call s:HL('gruvboxNeutralRedBold', s:red, s:none, s:bold)
call s:HL('gruvboxNeutralGreen', s:green)
call s:HL('gruvboxNeutralGreenBold', s:green, s:none, s:bold)
call s:HL('gruvboxNeutralYellow', s:yellow)
call s:HL('gruvboxNeutralYellowBold', s:yellow, s:none, s:bold)
call s:HL('gruvboxNeutralBlue', s:blue)
call s:HL('gruvboxNeutralBlueBold', s:blue, s:none, s:bold)
call s:HL('gruvboxNeutralPurple', s:purple)
call s:HL('gruvboxNeutralPurpleBold', s:purple, s:none, s:bold)
call s:HL('gruvboxNeutralAqua', s:aqua)
call s:HL('gruvboxNeutralAquaBold', s:aqua, s:none, s:bold)
call s:HL('gruvboxNeutralOrange', s:orange)
call s:HL('gruvboxNeutralOrangeBold', s:orange, s:none, s:bold)

call s:HL('gruvboxNeutralRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('gruvboxNeutralOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvboxNeutral/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText gruvboxNeutralBg2
hi! link SpecialKey gruvboxNeutralBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory gruvboxNeutralGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title gruvboxNeutralGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg gruvboxNeutralYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg gruvboxNeutralYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question gruvboxNeutralOrangeBold
" Warning messages
hi! link WarningMsg gruvboxNeutralRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:gruvboxNeutral_improved_strings == 0
  hi! link Special gruvboxNeutralOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement gruvboxNeutralRed
" if, then, else, endif, swicth, etc.
hi! link Conditional gruvboxNeutralRed
" for, do, while, etc.
hi! link Repeat gruvboxNeutralRed
" case, default, etc.
hi! link Label gruvboxNeutralRed
" try, catch, throw
hi! link Exception gruvboxNeutralRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword gruvboxNeutralRed

" Variable name
hi! link Identifier gruvboxNeutralBlue
" Function name
hi! link Function gruvboxNeutralOrangeBold

" Generic preprocessor
hi! link PreProc gruvboxNeutralAqua
" Preprocessor #include
hi! link Include gruvboxNeutralAqua
" Preprocessor #define
hi! link Define gruvboxNeutralAqua
" Same as Define
hi! link Macro gruvboxNeutralAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit gruvboxNeutralAqua

" Generic constant
hi! link Constant gruvboxNeutralPurple
" Character constant: 'c', '/n'
hi! link Character gruvboxNeutralPurple
" String constant: "this is a string"
if g:gruvboxNeutral_improved_strings == 0
  call s:HL('String',  s:aqua, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean gruvboxNeutralRedBold
" Number constant: 234, 0xff
hi! link Number gruvboxNeutralGreen
" Floating point constant: 2.3e10
hi! link Float gruvboxNeutralGreen

" Generic type
hi! link Type gruvboxNeutralYellow
" static, register, volatile, etc
hi! link StorageClass gruvboxNeutralOrange
" struct, union, enum, etc.
hi! link Structure gruvboxNeutralAqua
" typedef
hi! link Typedef gruvboxNeutralYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvboxNeutral_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvboxNeutral_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd gruvboxNeutralGreenSign
hi! link GitGutterChange gruvboxNeutralAquaSign
hi! link GitGutterDelete gruvboxNeutralRedSign
hi! link GitGutterChangeDelete gruvboxNeutralAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile gruvboxNeutralGreen
hi! link gitcommitDiscardedFile gruvboxNeutralRed

" }}}
" Signify: {{{

hi! link SignifySignAdd gruvboxNeutralGreenSign
hi! link SignifySignChange gruvboxNeutralAquaSign
hi! link SignifySignDelete gruvboxNeutralRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign gruvboxNeutralRedSign
hi! link SyntasticWarningSign gruvboxNeutralYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   gruvboxNeutralBlueSign
hi! link SignatureMarkerText gruvboxNeutralPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl gruvboxNeutralBlueSign
hi! link ShowMarksHLu gruvboxNeutralBlueSign
hi! link ShowMarksHLo gruvboxNeutralBlueSign
hi! link ShowMarksHLm gruvboxNeutralBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch gruvboxNeutralYellow
hi! link CtrlPNoEntries gruvboxNeutralRed
hi! link CtrlPPrtBase gruvboxNeutralBg2
hi! link CtrlPPrtCursor gruvboxNeutralBlue
hi! link CtrlPLinePre gruvboxNeutralBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket gruvboxNeutralFg3
hi! link StartifyFile gruvboxNeutralFg1
hi! link StartifyNumber gruvboxNeutralBlue
hi! link StartifyPath gruvboxNeutralGray
hi! link StartifySlash gruvboxNeutralGray
hi! link StartifySection gruvboxNeutralYellow
hi! link StartifySpecial gruvboxNeutralBg2
hi! link StartifyHeader gruvboxNeutralOrange
hi! link StartifyFooter gruvboxNeutralBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign gruvboxNeutralRedSign
hi! link ALEWarningSign gruvboxNeutralYellowSign
hi! link ALEInfoSign gruvboxNeutralBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail gruvboxNeutralAqua
hi! link DirvishArg gruvboxNeutralYellow

" }}}
" Netrw: {{{

hi! link netrwDir gruvboxNeutralAqua
hi! link netrwClassify gruvboxNeutralAqua
hi! link netrwLink gruvboxNeutralGray
hi! link netrwSymLink gruvboxNeutralFg1
hi! link netrwExe gruvboxNeutralYellow
hi! link netrwComment gruvboxNeutralGray
hi! link netrwList gruvboxNeutralBlue
hi! link netrwHelpCmd gruvboxNeutralAqua
hi! link netrwCmdSep gruvboxNeutralFg3
hi! link netrwVersion gruvboxNeutralGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir gruvboxNeutralAqua
hi! link NERDTreeDirSlash gruvboxNeutralAqua

hi! link NERDTreeOpenable gruvboxNeutralOrange
hi! link NERDTreeClosable gruvboxNeutralOrange

hi! link NERDTreeFile gruvboxNeutralFg1
hi! link NERDTreeExecFile gruvboxNeutralYellow

hi! link NERDTreeUp gruvboxNeutralGray
hi! link NERDTreeCWD gruvboxNeutralGreen
hi! link NERDTreeHelp gruvboxNeutralFg1

hi! link NERDTreeToggleOn gruvboxNeutralGreen
hi! link NERDTreeToggleOff gruvboxNeutralRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign gruvboxNeutralRedSign
hi! link CocWarningSign gruvboxNeutralOrangeSign
hi! link CocInfoSign gruvboxNeutralYellowSign
hi! link CocHintSign gruvboxNeutralBlueSign
hi! link CocErrorFloat gruvboxNeutralRed
hi! link CocWarningFloat gruvboxNeutralOrange
hi! link CocInfoFloat gruvboxNeutralYellow
hi! link CocHintFloat gruvboxNeutralBlue
hi! link CocDiagnosticsError gruvboxNeutralRed
hi! link CocDiagnosticsWarning gruvboxNeutralOrange
hi! link CocDiagnosticsInfo gruvboxNeutralYellow
hi! link CocDiagnosticsHint gruvboxNeutralBlue

hi! link CocSelectedText gruvboxNeutralRed
hi! link CocCodeLens gruvboxNeutralGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded gruvboxNeutralGreen
hi! link diffRemoved gruvboxNeutralRed
hi! link diffChanged gruvboxNeutralAqua

hi! link diffFile gruvboxNeutralOrange
hi! link diffNewFile gruvboxNeutralYellow

hi! link diffLine gruvboxNeutralBlue

" }}}
" Html: {{{

hi! link htmlTag gruvboxNeutralBlue
hi! link htmlEndTag gruvboxNeutralBlue

hi! link htmlTagName gruvboxNeutralAquaBold
hi! link htmlArg gruvboxNeutralAqua

hi! link htmlScriptTag gruvboxNeutralPurple
hi! link htmlTagN gruvboxNeutralFg1
hi! link htmlSpecialTagName gruvboxNeutralAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar gruvboxNeutralOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag gruvboxNeutralBlue
hi! link xmlEndTag gruvboxNeutralBlue
hi! link xmlTagName gruvboxNeutralBlue
hi! link xmlEqual gruvboxNeutralBlue
hi! link docbkKeyword gruvboxNeutralAquaBold

hi! link xmlDocTypeDecl gruvboxNeutralGray
hi! link xmlDocTypeKeyword gruvboxNeutralPurple
hi! link xmlCdataStart gruvboxNeutralGray
hi! link xmlCdataCdata gruvboxNeutralPurple
hi! link dtdFunction gruvboxNeutralGray
hi! link dtdTagName gruvboxNeutralPurple

hi! link xmlAttrib gruvboxNeutralAqua
hi! link xmlProcessingDelim gruvboxNeutralGray
hi! link dtdParamEntityPunct gruvboxNeutralGray
hi! link dtdParamEntityDPunct gruvboxNeutralGray
hi! link xmlAttribPunct gruvboxNeutralGray

hi! link xmlEntity gruvboxNeutralOrange
hi! link xmlEntityPunct gruvboxNeutralOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation gruvboxNeutralOrange
hi! link vimBracket gruvboxNeutralOrange
hi! link vimMapModKey gruvboxNeutralOrange
hi! link vimFuncSID gruvboxNeutralFg3
hi! link vimSetSep gruvboxNeutralFg3
hi! link vimSep gruvboxNeutralFg3
hi! link vimContinue gruvboxNeutralFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword gruvboxNeutralBlue
hi! link clojureCond gruvboxNeutralOrange
hi! link clojureSpecial gruvboxNeutralOrange
hi! link clojureDefine gruvboxNeutralOrange

hi! link clojureFunc gruvboxNeutralYellow
hi! link clojureRepeat gruvboxNeutralYellow
hi! link clojureCharacter gruvboxNeutralAqua
hi! link clojureStringEscape gruvboxNeutralAqua
hi! link clojureException gruvboxNeutralRed

hi! link clojureRegexp gruvboxNeutralAqua
hi! link clojureRegexpEscape gruvboxNeutralAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen gruvboxNeutralFg3
hi! link clojureAnonArg gruvboxNeutralYellow
hi! link clojureVariable gruvboxNeutralBlue
hi! link clojureMacro gruvboxNeutralOrange

hi! link clojureMeta gruvboxNeutralYellow
hi! link clojureDeref gruvboxNeutralYellow
hi! link clojureQuote gruvboxNeutralYellow
hi! link clojureUnquote gruvboxNeutralYellow

" }}}
" C: {{{

hi! link cOperator gruvboxNeutralPurple
hi! link cStructure gruvboxNeutralOrange

" }}}
" Python: {{{

hi! link pythonBuiltin gruvboxNeutralOrange
hi! link pythonBuiltinObj gruvboxNeutralOrange
hi! link pythonBuiltinFunc gruvboxNeutralOrange
hi! link pythonFunction gruvboxNeutralAqua
hi! link pythonDecorator gruvboxNeutralRed
hi! link pythonInclude gruvboxNeutralBlue
hi! link pythonImport gruvboxNeutralBlue
hi! link pythonRun gruvboxNeutralBlue
hi! link pythonCoding gruvboxNeutralBlue
hi! link pythonOperator gruvboxNeutralRed
hi! link pythonException gruvboxNeutralRed
hi! link pythonExceptions gruvboxNeutralPurple
hi! link pythonBoolean gruvboxNeutralPurple
hi! link pythonDot gruvboxNeutralFg3
hi! link pythonConditional gruvboxNeutralRed
hi! link pythonRepeat gruvboxNeutralRed
hi! link pythonDottedName gruvboxNeutralGreenBold

" }}}
" CSS: {{{

hi! link cssBraces gruvboxNeutralBlue
hi! link cssFunctionName gruvboxNeutralYellow
hi! link cssIdentifier gruvboxNeutralOrange
hi! link cssClassName gruvboxNeutralGreen
hi! link cssColor gruvboxNeutralBlue
hi! link cssSelectorOp gruvboxNeutralBlue
hi! link cssSelectorOp2 gruvboxNeutralBlue
hi! link cssImportant gruvboxNeutralGreen
hi! link cssVendor gruvboxNeutralFg1

hi! link cssTextProp gruvboxNeutralAqua
hi! link cssAnimationProp gruvboxNeutralAqua
hi! link cssUIProp gruvboxNeutralYellow
hi! link cssTransformProp gruvboxNeutralAqua
hi! link cssTransitionProp gruvboxNeutralAqua
hi! link cssPrintProp gruvboxNeutralAqua
hi! link cssPositioningProp gruvboxNeutralYellow
hi! link cssBoxProp gruvboxNeutralAqua
hi! link cssFontDescriptorProp gruvboxNeutralAqua
hi! link cssFlexibleBoxProp gruvboxNeutralAqua
hi! link cssBorderOutlineProp gruvboxNeutralAqua
hi! link cssBackgroundProp gruvboxNeutralAqua
hi! link cssMarginProp gruvboxNeutralAqua
hi! link cssListProp gruvboxNeutralAqua
hi! link cssTableProp gruvboxNeutralAqua
hi! link cssFontProp gruvboxNeutralAqua
hi! link cssPaddingProp gruvboxNeutralAqua
hi! link cssDimensionProp gruvboxNeutralAqua
hi! link cssRenderProp gruvboxNeutralAqua
hi! link cssColorProp gruvboxNeutralAqua
hi! link cssGeneratedContentProp gruvboxNeutralAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces gruvboxNeutralFg1
hi! link javaScriptFunction gruvboxNeutralAqua
hi! link javaScriptIdentifier gruvboxNeutralRed
hi! link javaScriptMember gruvboxNeutralBlue
hi! link javaScriptNumber gruvboxNeutralPurple
hi! link javaScriptNull gruvboxNeutralPurple
hi! link javaScriptParens gruvboxNeutralFg3

" }}}
" YAJS: {{{

hi! link javascriptImport gruvboxNeutralAqua
hi! link javascriptExport gruvboxNeutralAqua
hi! link javascriptClassKeyword gruvboxNeutralAqua
hi! link javascriptClassExtends gruvboxNeutralAqua
hi! link javascriptDefault gruvboxNeutralAqua

hi! link javascriptClassName gruvboxNeutralYellow
hi! link javascriptClassSuperName gruvboxNeutralYellow
hi! link javascriptGlobal gruvboxNeutralYellow

hi! link javascriptEndColons gruvboxNeutralFg1
hi! link javascriptFuncArg gruvboxNeutralFg1
hi! link javascriptGlobalMethod gruvboxNeutralFg1
hi! link javascriptNodeGlobal gruvboxNeutralFg1
hi! link javascriptBOMWindowProp gruvboxNeutralFg1
hi! link javascriptArrayMethod gruvboxNeutralFg1
hi! link javascriptArrayStaticMethod gruvboxNeutralFg1
hi! link javascriptCacheMethod gruvboxNeutralFg1
hi! link javascriptDateMethod gruvboxNeutralFg1
hi! link javascriptMathStaticMethod gruvboxNeutralFg1

" hi! link javascriptProp gruvboxNeutralFg1
hi! link javascriptURLUtilsProp gruvboxNeutralFg1
hi! link javascriptBOMNavigatorProp gruvboxNeutralFg1
hi! link javascriptDOMDocMethod gruvboxNeutralFg1
hi! link javascriptDOMDocProp gruvboxNeutralFg1
hi! link javascriptBOMLocationMethod gruvboxNeutralFg1
hi! link javascriptBOMWindowMethod gruvboxNeutralFg1
hi! link javascriptStringMethod gruvboxNeutralFg1

hi! link javascriptVariable gruvboxNeutralOrange
" hi! link javascriptVariable gruvboxNeutralRed
" hi! link javascriptIdentifier gruvboxNeutralOrange
" hi! link javascriptClassSuper gruvboxNeutralOrange
hi! link javascriptIdentifier gruvboxNeutralOrange
hi! link javascriptClassSuper gruvboxNeutralOrange

" hi! link javascriptFuncKeyword gruvboxNeutralOrange
" hi! link javascriptAsyncFunc gruvboxNeutralOrange
hi! link javascriptFuncKeyword gruvboxNeutralAqua
hi! link javascriptAsyncFunc gruvboxNeutralAqua
hi! link javascriptClassStatic gruvboxNeutralOrange

hi! link javascriptOperator gruvboxNeutralRed
hi! link javascriptForOperator gruvboxNeutralRed
hi! link javascriptYield gruvboxNeutralRed
hi! link javascriptExceptions gruvboxNeutralRed
hi! link javascriptMessage gruvboxNeutralRed

hi! link javascriptTemplateSB gruvboxNeutralAqua
hi! link javascriptTemplateSubstitution gruvboxNeutralFg1

" hi! link javascriptLabel gruvboxNeutralBlue
" hi! link javascriptObjectLabel gruvboxNeutralBlue
" hi! link javascriptPropertyName gruvboxNeutralBlue
hi! link javascriptLabel gruvboxNeutralFg1
hi! link javascriptObjectLabel gruvboxNeutralFg1
hi! link javascriptPropertyName gruvboxNeutralFg1

hi! link javascriptLogicSymbols gruvboxNeutralFg1
hi! link javascriptArrowFunc gruvboxNeutralYellow

hi! link javascriptDocParamName gruvboxNeutralFg4
hi! link javascriptDocTags gruvboxNeutralFg4
hi! link javascriptDocNotation gruvboxNeutralFg4
hi! link javascriptDocParamType gruvboxNeutralFg4
hi! link javascriptDocNamedParamType gruvboxNeutralFg4

hi! link javascriptBrackets gruvboxNeutralFg1
hi! link javascriptDOMElemAttrs gruvboxNeutralFg1
hi! link javascriptDOMEventMethod gruvboxNeutralFg1
hi! link javascriptDOMNodeMethod gruvboxNeutralFg1
hi! link javascriptDOMStorageMethod gruvboxNeutralFg1
hi! link javascriptHeadersMethod gruvboxNeutralFg1

hi! link javascriptAsyncFuncKeyword gruvboxNeutralRed
hi! link javascriptAwaitFuncKeyword gruvboxNeutralRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword gruvboxNeutralAqua
hi! link jsExtendsKeyword gruvboxNeutralAqua
hi! link jsExportDefault gruvboxNeutralAqua
hi! link jsTemplateBraces gruvboxNeutralAqua
hi! link jsGlobalNodeObjects gruvboxNeutralFg1
hi! link jsGlobalObjects gruvboxNeutralFg1
hi! link jsFunction gruvboxNeutralAqua
hi! link jsFuncParens gruvboxNeutralFg3
hi! link jsParens gruvboxNeutralFg3
hi! link jsNull gruvboxNeutralPurple
hi! link jsUndefined gruvboxNeutralPurple
hi! link jsClassDefinition gruvboxNeutralYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved gruvboxNeutralAqua
hi! link typeScriptLabel gruvboxNeutralAqua
hi! link typeScriptFuncKeyword gruvboxNeutralAqua
hi! link typeScriptIdentifier gruvboxNeutralOrange
hi! link typeScriptBraces gruvboxNeutralFg1
hi! link typeScriptEndColons gruvboxNeutralFg1
hi! link typeScriptDOMObjects gruvboxNeutralFg1
hi! link typeScriptAjaxMethods gruvboxNeutralFg1
hi! link typeScriptLogicSymbols gruvboxNeutralFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects gruvboxNeutralFg1
hi! link typeScriptParens gruvboxNeutralFg3
hi! link typeScriptOpSymbols gruvboxNeutralFg3
hi! link typeScriptHtmlElemProperties gruvboxNeutralFg1
hi! link typeScriptNull gruvboxNeutralPurple
hi! link typeScriptInterpolationDelimiter gruvboxNeutralAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword gruvboxNeutralAqua
hi! link purescriptModuleName gruvboxNeutralFg1
hi! link purescriptWhere gruvboxNeutralAqua
hi! link purescriptDelimiter gruvboxNeutralFg4
hi! link purescriptType gruvboxNeutralFg1
hi! link purescriptImportKeyword gruvboxNeutralAqua
hi! link purescriptHidingKeyword gruvboxNeutralAqua
hi! link purescriptAsKeyword gruvboxNeutralAqua
hi! link purescriptStructure gruvboxNeutralAqua
hi! link purescriptOperator gruvboxNeutralBlue

hi! link purescriptTypeVar gruvboxNeutralFg1
hi! link purescriptConstructor gruvboxNeutralFg1
hi! link purescriptFunction gruvboxNeutralFg1
hi! link purescriptConditional gruvboxNeutralOrange
hi! link purescriptBacktick gruvboxNeutralOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp gruvboxNeutralFg3
hi! link coffeeSpecialOp gruvboxNeutralFg3
hi! link coffeeCurly gruvboxNeutralOrange
hi! link coffeeParen gruvboxNeutralFg3
hi! link coffeeBracket gruvboxNeutralOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter gruvboxNeutralGreen
hi! link rubyInterpolationDelimiter gruvboxNeutralAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier gruvboxNeutralRed
hi! link objcDirective gruvboxNeutralBlue

" }}}
" Go: {{{

hi! link goDirective gruvboxNeutralAqua
hi! link goConstants gruvboxNeutralPurple
hi! link goDeclaration gruvboxNeutralRed
hi! link goDeclType gruvboxNeutralBlue
hi! link goBuiltins gruvboxNeutralOrange

" }}}
" Lua: {{{

hi! link luaIn gruvboxNeutralRed
hi! link luaFunction gruvboxNeutralAqua
hi! link luaTable gruvboxNeutralOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp gruvboxNeutralFg3
hi! link moonExtendedOp gruvboxNeutralFg3
hi! link moonFunction gruvboxNeutralFg3
hi! link moonObject gruvboxNeutralYellow

" }}}
" Java: {{{

hi! link javaAnnotation gruvboxNeutralBlue
hi! link javaDocTags gruvboxNeutralAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen gruvboxNeutralFg3
hi! link javaParen1 gruvboxNeutralFg3
hi! link javaParen2 gruvboxNeutralFg3
hi! link javaParen3 gruvboxNeutralFg3
hi! link javaParen4 gruvboxNeutralFg3
hi! link javaParen5 gruvboxNeutralFg3
hi! link javaOperator gruvboxNeutralOrange

hi! link javaVarArg gruvboxNeutralGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter gruvboxNeutralGreen
hi! link elixirInterpolationDelimiter gruvboxNeutralAqua

hi! link elixirModuleDeclaration gruvboxNeutralYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition gruvboxNeutralFg1
hi! link scalaCaseFollowing gruvboxNeutralFg1
hi! link scalaCapitalWord gruvboxNeutralFg1
hi! link scalaTypeExtension gruvboxNeutralFg1

hi! link scalaKeyword gruvboxNeutralRed
hi! link scalaKeywordModifier gruvboxNeutralRed

hi! link scalaSpecial gruvboxNeutralAqua
hi! link scalaOperator gruvboxNeutralFg1

hi! link scalaTypeDeclaration gruvboxNeutralYellow
hi! link scalaTypeTypePostDeclaration gruvboxNeutralYellow

hi! link scalaInstanceDeclaration gruvboxNeutralFg1
hi! link scalaInterpolation gruvboxNeutralAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 gruvboxNeutralGreenBold
hi! link markdownH2 gruvboxNeutralGreenBold
hi! link markdownH3 gruvboxNeutralYellowBold
hi! link markdownH4 gruvboxNeutralYellowBold
hi! link markdownH5 gruvboxNeutralYellow
hi! link markdownH6 gruvboxNeutralYellow

hi! link markdownCode gruvboxNeutralAqua
hi! link markdownCodeBlock gruvboxNeutralAqua
hi! link markdownCodeDelimiter gruvboxNeutralAqua

hi! link markdownBlockquote gruvboxNeutralGray
hi! link markdownListMarker gruvboxNeutralGray
hi! link markdownOrderedListMarker gruvboxNeutralGray
hi! link markdownRule gruvboxNeutralGray
hi! link markdownHeadingRule gruvboxNeutralGray

hi! link markdownUrlDelimiter gruvboxNeutralFg3
hi! link markdownLinkDelimiter gruvboxNeutralFg3
hi! link markdownLinkTextDelimiter gruvboxNeutralFg3

hi! link markdownHeadingDelimiter gruvboxNeutralOrange
hi! link markdownUrl gruvboxNeutralPurple
hi! link markdownUrlTitleDelimiter gruvboxNeutralGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType gruvboxNeutralYellow
" hi! link haskellOperators gruvboxNeutralOrange
" hi! link haskellConditional gruvboxNeutralAqua
" hi! link haskellLet gruvboxNeutralOrange
"
hi! link haskellType gruvboxNeutralFg1
hi! link haskellIdentifier gruvboxNeutralFg1
hi! link haskellSeparator gruvboxNeutralFg1
hi! link haskellDelimiter gruvboxNeutralFg4
hi! link haskellOperators gruvboxNeutralBlue
"
hi! link haskellBacktick gruvboxNeutralOrange
hi! link haskellStatement gruvboxNeutralOrange
hi! link haskellConditional gruvboxNeutralOrange

hi! link haskellLet gruvboxNeutralAqua
hi! link haskellDefault gruvboxNeutralAqua
hi! link haskellWhere gruvboxNeutralAqua
hi! link haskellBottom gruvboxNeutralAqua
hi! link haskellBlockKeywords gruvboxNeutralAqua
hi! link haskellImportKeywords gruvboxNeutralAqua
hi! link haskellDeclKeyword gruvboxNeutralAqua
hi! link haskellDeriving gruvboxNeutralAqua
hi! link haskellAssocType gruvboxNeutralAqua

hi! link haskellNumber gruvboxNeutralPurple
hi! link haskellPragma gruvboxNeutralPurple

hi! link haskellString gruvboxNeutralGreen
hi! link haskellChar gruvboxNeutralGreen

" }}}
" Json: {{{

hi! link jsonKeyword gruvboxNeutralGreen
hi! link jsonQuote gruvboxNeutralGreen
hi! link jsonBraces gruvboxNeutralFg1
hi! link jsonString gruvboxNeutralFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! s:gruvboxNeutralHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! s:gruvboxNeutralHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
