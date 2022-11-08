" -----------------------------------------------------------------------------
" File: superNova.vim
" Description: Retro groove color scheme for Vim based on gruvbox
" Author: bvgross <bvgross@gmx.com>
" Source: https://github.com/bvgross/superNova
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

let g:colors_name='superNova'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:superNova_bold')
  let g:superNova_bold=1
endif
if !exists('g:superNova_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:superNova_italic=1
  else
    let g:superNova_italic=0
  endif
endif
if !exists('g:superNova_undercurl')
  let g:superNova_undercurl=1
endif
if !exists('g:superNova_underline')
  let g:superNova_underline=1
endif
if !exists('g:superNova_inverse')
  let g:superNova_inverse=1
endif

if !exists('g:superNova_guisp_fallback') || index(['fg', 'bg'], g:superNova_guisp_fallback) == -1
  let g:superNova_guisp_fallback='NONE'
endif

if !exists('g:superNova_improved_strings')
  let g:superNova_improved_strings=0
endif

if !exists('g:superNova_improved_warnings')
  let g:superNova_improved_warnings=0
endif

if !exists('g:superNova_termcolors')
  let g:superNova_termcolors=256
endif

if !exists('g:superNova_invert_indent_guides')
  let g:superNova_invert_indent_guides=0
endif

if exists('g:superNova_contrast')
  echo 'g:superNova_contrast is deprecated; use g:superNova_contrast_light and g:superNova_contrast_dark instead'
endif

if !exists('g:superNova_contrast_dark')
  let g:superNova_contrast_dark='medium'
endif

if !exists('g:superNova_contrast_light')
  let g:superNova_contrast_light='medium'
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
let s:gb.bright_blue    = ['#72b4b6', 109]     " 131-165-152
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
if g:superNova_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:superNova_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:superNova_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:superNova_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:superNova_inverse == 0
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
  if g:superNova_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:superNova_contrast_dark == 'hard'
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
  if g:superNova_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:superNova_contrast_light == 'hard'
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
if g:superNova_termcolors == 16
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
if exists('g:superNova_hls_cursor')
  let s:hls_cursor = get(s:gb, g:superNova_hls_cursor)
endif

let s:number_column = s:none
if exists('g:superNova_number_column')
  let s:number_column = get(s:gb, g:superNova_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:superNova_sign_column')
    let s:sign_column = get(s:gb, g:superNova_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:superNova_color_column')
  let s:color_column = get(s:gb, g:superNova_color_column)
endif

let s:vert_split = s:bg0
if exists('g:superNova_vert_split')
  let s:vert_split = get(s:gb, g:superNova_vert_split)
endif

let s:invert_signs = ''
if exists('g:superNova_invert_signs')
  if g:superNova_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:superNova_invert_selection')
  if g:superNova_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:superNova_invert_tabline')
  if g:superNova_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:superNova_italicize_comments')
  if g:superNova_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:superNova_italicize_strings')
  if g:superNova_italicize_strings == 1
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
    if g:superNova_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:superNova_guisp_fallback == 'bg'
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
" superNova Hi Groups: {{{

" memoize common hi groups
call s:HL('superNovaFg0', s:fg0)
call s:HL('superNovaFg1', s:fg1)
call s:HL('superNovaFg2', s:fg2)
call s:HL('superNovaFg3', s:fg3)
call s:HL('superNovaFg4', s:fg4)
call s:HL('superNovaGray', s:gray)
call s:HL('superNovaBg0', s:bg0)
call s:HL('superNovaBg1', s:bg1)
call s:HL('superNovaBg2', s:bg2)
call s:HL('superNovaBg3', s:bg3)
call s:HL('superNovaBg4', s:bg4)

call s:HL('superNovaRed', s:red)
call s:HL('superNovaRedBold', s:red, s:none, s:bold)
call s:HL('superNovaGreen', s:green)
call s:HL('superNovaGreenBold', s:green, s:none, s:bold)
call s:HL('superNovaYellow', s:yellow)
call s:HL('superNovaYellowBold', s:yellow, s:none, s:bold)
call s:HL('superNovaBlue', s:blue)
call s:HL('superNovaBlueBold', s:blue, s:none, s:bold)
call s:HL('superNovaPurple', s:purple)
call s:HL('superNovaPurpleBold', s:purple, s:none, s:bold)
call s:HL('superNovaAqua', s:aqua)
call s:HL('superNovaAquaBold', s:aqua, s:none, s:bold)
call s:HL('superNovaOrange', s:orange)
call s:HL('superNovaOrangeBold', s:orange, s:none, s:bold)

call s:HL('superNovaRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('superNovaGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('superNovaYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('superNovaBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('superNovaPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('superNovaAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('superNovaOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/superNova/issues/7
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

hi! link NonText superNovaBg2
hi! link SpecialKey superNovaBg2

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
hi! link Directory superNovaGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title superNovaGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg superNovaYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg superNovaYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question superNovaOrangeBold
" Warning messages
hi! link WarningMsg superNovaRedBold

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

if g:superNova_improved_strings == 0
  hi! link Special superNovaOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement superNovaBlue
" if, then, else, endif, swicth, etc.
hi! link Conditional superNovaPurple
" for, do, while, etc.
hi! link Repeat superNovaPurple
" case, default, etc.
hi! link Label superNovaPurple
" try, catch, throw
hi! link Exception superNovaPurple
" sizeof, "+", "*", etc.
hi! link Operator superNovaBlue
" Any other keyword
hi! link Keyword superNovaRed

" Variable name
hi! link Identifier superNovaBlue
" Function name
hi! link Function superNovaYellowBold

" Generic preprocessor
hi! link PreProc superNovaAqua
" Preprocessor #include
hi! link Include superNovaGray
" Preprocessor #define
hi! link Define superNovaGray
" Same as Define
hi! link Macro superNovaAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit superNovaRed

" Generic constant
hi! link Constant superNovaPurple
" Character constant: 'c', '/n'
hi! link Character superNovaPurple
" String constant: "this is a string"
if g:superNova_improved_strings == 0
  call s:HL('String',  s:aqua, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean superNovaRedBold
" Number constant: 234, 0xff
hi! link Number superNovaGreenBold
" Floating point constant: 2.3e10
hi! link Float superNovaGreenBold

" Generic type
hi! link Type superNovaOrange
" static, register, volatile, etc
hi! link StorageClass superNovaYellow
" struct, union, enum, etc.
hi! link Structure superNovaAqua
" typedef
hi! link Typedef superNovaOrange

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
  if g:superNova_improved_warnings == 0
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
  if g:superNova_invert_indent_guides == 0
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

hi! link GitGutterAdd superNovaGreenSign
hi! link GitGutterChange superNovaAquaSign
hi! link GitGutterDelete superNovaRedSign
hi! link GitGutterChangeDelete superNovaAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile superNovaGreen
hi! link gitcommitDiscardedFile superNovaRed

" }}}
" Signify: {{{

hi! link SignifySignAdd superNovaGreenSign
hi! link SignifySignChange superNovaAquaSign
hi! link SignifySignDelete superNovaRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign superNovaRedSign
hi! link SyntasticWarningSign superNovaYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   superNovaBlueSign
hi! link SignatureMarkerText superNovaPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl superNovaBlueSign
hi! link ShowMarksHLu superNovaBlueSign
hi! link ShowMarksHLo superNovaBlueSign
hi! link ShowMarksHLm superNovaBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch superNovaYellow
hi! link CtrlPNoEntries superNovaRed
hi! link CtrlPPrtBase superNovaBg2
hi! link CtrlPPrtCursor superNovaBlue
hi! link CtrlPLinePre superNovaBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket superNovaFg3
hi! link StartifyFile superNovaFg1
hi! link StartifyNumber superNovaBlue
hi! link StartifyPath superNovaGray
hi! link StartifySlash superNovaGray
hi! link StartifySection superNovaYellow
hi! link StartifySpecial superNovaBg2
hi! link StartifyHeader superNovaOrange
hi! link StartifyFooter superNovaBg2

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

hi! link ALEErrorSign superNovaRedSign
hi! link ALEWarningSign superNovaYellowSign
hi! link ALEInfoSign superNovaBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail superNovaAqua
hi! link DirvishArg superNovaYellow

" }}}
" Netrw: {{{

hi! link netrwDir superNovaAqua
hi! link netrwClassify superNovaAqua
hi! link netrwLink superNovaGray
hi! link netrwSymLink superNovaFg1
hi! link netrwExe superNovaYellow
hi! link netrwComment superNovaGray
hi! link netrwList superNovaBlue
hi! link netrwHelpCmd superNovaAqua
hi! link netrwCmdSep superNovaFg3
hi! link netrwVersion superNovaGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir superNovaAqua
hi! link NERDTreeDirSlash superNovaAqua

hi! link NERDTreeOpenable superNovaOrange
hi! link NERDTreeClosable superNovaOrange

hi! link NERDTreeFile superNovaFg1
hi! link NERDTreeExecFile superNovaYellow

hi! link NERDTreeUp superNovaGray
hi! link NERDTreeCWD superNovaGreen
hi! link NERDTreeHelp superNovaFg1

hi! link NERDTreeToggleOn superNovaGreen
hi! link NERDTreeToggleOff superNovaRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign superNovaRedSign
hi! link CocWarningSign superNovaOrangeSign
hi! link CocInfoSign superNovaYellowSign
hi! link CocHintSign superNovaBlueSign
hi! link CocErrorFloat superNovaRed
hi! link CocWarningFloat superNovaOrange
hi! link CocInfoFloat superNovaYellow
hi! link CocHintFloat superNovaBlue
hi! link CocDiagnosticsError superNovaRed
hi! link CocDiagnosticsWarning superNovaOrange
hi! link CocDiagnosticsInfo superNovaYellow
hi! link CocDiagnosticsHint superNovaBlue

hi! link CocSelectedText superNovaRed
hi! link CocCodeLens superNovaGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:blue)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded superNovaGreen
hi! link diffRemoved superNovaRed
hi! link diffChanged superNovaAqua

hi! link diffFile superNovaOrange
hi! link diffNewFile superNovaYellow

hi! link diffLine superNovaBlue

" }}}
" Html: {{{

hi! link htmlTag superNovaBlue
hi! link htmlEndTag superNovaBlue

hi! link htmlTagName superNovaAquaBold
hi! link htmlArg superNovaAqua

hi! link htmlScriptTag superNovaPurple
hi! link htmlTagN superNovaFg1
hi! link htmlSpecialTagName superNovaAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar superNovaOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag superNovaBlue
hi! link xmlEndTag superNovaBlue
hi! link xmlTagName superNovaBlue
hi! link xmlEqual superNovaBlue
hi! link docbkKeyword superNovaAquaBold

hi! link xmlDocTypeDecl superNovaGray
hi! link xmlDocTypeKeyword superNovaPurple
hi! link xmlCdataStart superNovaGray
hi! link xmlCdataCdata superNovaPurple
hi! link dtdFunction superNovaGray
hi! link dtdTagName superNovaPurple

hi! link xmlAttrib superNovaAqua
hi! link xmlProcessingDelim superNovaGray
hi! link dtdParamEntityPunct superNovaGray
hi! link dtdParamEntityDPunct superNovaGray
hi! link xmlAttribPunct superNovaGray

hi! link xmlEntity superNovaOrange
hi! link xmlEntityPunct superNovaOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation superNovaOrange
hi! link vimBracket superNovaOrange
hi! link vimMapModKey superNovaOrange
hi! link vimFuncSID superNovaFg3
hi! link vimSetSep superNovaFg3
hi! link vimSep superNovaFg3
hi! link vimContinue superNovaFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword superNovaBlue
hi! link clojureCond superNovaOrange
hi! link clojureSpecial superNovaOrange
hi! link clojureDefine superNovaOrange

hi! link clojureFunc superNovaYellow
hi! link clojureRepeat superNovaYellow
hi! link clojureCharacter superNovaAqua
hi! link clojureStringEscape superNovaAqua
hi! link clojureException superNovaRed

hi! link clojureRegexp superNovaAqua
hi! link clojureRegexpEscape superNovaAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen superNovaFg3
hi! link clojureAnonArg superNovaYellow
hi! link clojureVariable superNovaBlue
hi! link clojureMacro superNovaOrange

hi! link clojureMeta superNovaYellow
hi! link clojureDeref superNovaYellow
hi! link clojureQuote superNovaYellow
hi! link clojureUnquote superNovaYellow

" }}}
" C: {{{

hi! link cOperator superNovaPurple
hi! link cStructure superNovaOrange

" }}}
" Python: {{{

hi! link pythonBuiltin superNovaOrange
hi! link pythonBuiltinObj superNovaOrange
hi! link pythonBuiltinFunc superNovaOrange
hi! link pythonFunction superNovaAqua
hi! link pythonDecorator superNovaRed
hi! link pythonInclude superNovaBlue
hi! link pythonImport superNovaBlue
hi! link pythonRun superNovaBlue
hi! link pythonCoding superNovaBlue
hi! link pythonOperator superNovaRed
hi! link pythonException superNovaRed
hi! link pythonExceptions superNovaPurple
hi! link pythonBoolean superNovaPurple
hi! link pythonDot superNovaFg3
hi! link pythonConditional superNovaRed
hi! link pythonRepeat superNovaRed
hi! link pythonDottedName superNovaGreenBold

" }}}
" CSS: {{{

hi! link cssBraces superNovaBlue
hi! link cssFunctionName superNovaYellow
hi! link cssIdentifier superNovaOrange
hi! link cssClassName superNovaGreen
hi! link cssColor superNovaBlue
hi! link cssSelectorOp superNovaBlue
hi! link cssSelectorOp2 superNovaBlue
hi! link cssImportant superNovaGreen
hi! link cssVendor superNovaFg1

hi! link cssTextProp superNovaAqua
hi! link cssAnimationProp superNovaAqua
hi! link cssUIProp superNovaYellow
hi! link cssTransformProp superNovaAqua
hi! link cssTransitionProp superNovaAqua
hi! link cssPrintProp superNovaAqua
hi! link cssPositioningProp superNovaYellow
hi! link cssBoxProp superNovaAqua
hi! link cssFontDescriptorProp superNovaAqua
hi! link cssFlexibleBoxProp superNovaAqua
hi! link cssBorderOutlineProp superNovaAqua
hi! link cssBackgroundProp superNovaAqua
hi! link cssMarginProp superNovaAqua
hi! link cssListProp superNovaAqua
hi! link cssTableProp superNovaAqua
hi! link cssFontProp superNovaAqua
hi! link cssPaddingProp superNovaAqua
hi! link cssDimensionProp superNovaAqua
hi! link cssRenderProp superNovaAqua
hi! link cssColorProp superNovaAqua
hi! link cssGeneratedContentProp superNovaAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces superNovaFg1
hi! link javaScriptFunction superNovaAqua
hi! link javaScriptIdentifier superNovaRed
hi! link javaScriptMember superNovaBlue
hi! link javaScriptNumber superNovaPurple
hi! link javaScriptNull superNovaPurple
hi! link javaScriptParens superNovaFg3

" }}}
" YAJS: {{{

hi! link javascriptImport superNovaAqua
hi! link javascriptExport superNovaAqua
hi! link javascriptClassKeyword superNovaAqua
hi! link javascriptClassExtends superNovaAqua
hi! link javascriptDefault superNovaAqua

hi! link javascriptClassName superNovaYellow
hi! link javascriptClassSuperName superNovaYellow
hi! link javascriptGlobal superNovaYellow

hi! link javascriptEndColons superNovaFg1
hi! link javascriptFuncArg superNovaFg1
hi! link javascriptGlobalMethod superNovaFg1
hi! link javascriptNodeGlobal superNovaFg1
hi! link javascriptBOMWindowProp superNovaFg1
hi! link javascriptArrayMethod superNovaFg1
hi! link javascriptArrayStaticMethod superNovaFg1
hi! link javascriptCacheMethod superNovaFg1
hi! link javascriptDateMethod superNovaFg1
hi! link javascriptMathStaticMethod superNovaFg1

" hi! link javascriptProp superNovaFg1
hi! link javascriptURLUtilsProp superNovaFg1
hi! link javascriptBOMNavigatorProp superNovaFg1
hi! link javascriptDOMDocMethod superNovaFg1
hi! link javascriptDOMDocProp superNovaFg1
hi! link javascriptBOMLocationMethod superNovaFg1
hi! link javascriptBOMWindowMethod superNovaFg1
hi! link javascriptStringMethod superNovaFg1

hi! link javascriptVariable superNovaOrange
" hi! link javascriptVariable superNovaRed
" hi! link javascriptIdentifier superNovaOrange
" hi! link javascriptClassSuper superNovaOrange
hi! link javascriptIdentifier superNovaOrange
hi! link javascriptClassSuper superNovaOrange

" hi! link javascriptFuncKeyword superNovaOrange
" hi! link javascriptAsyncFunc superNovaOrange
hi! link javascriptFuncKeyword superNovaAqua
hi! link javascriptAsyncFunc superNovaAqua
hi! link javascriptClassStatic superNovaOrange

hi! link javascriptOperator superNovaRed
hi! link javascriptForOperator superNovaRed
hi! link javascriptYield superNovaRed
hi! link javascriptExceptions superNovaRed
hi! link javascriptMessage superNovaRed

hi! link javascriptTemplateSB superNovaAqua
hi! link javascriptTemplateSubstitution superNovaFg1

" hi! link javascriptLabel superNovaBlue
" hi! link javascriptObjectLabel superNovaBlue
" hi! link javascriptPropertyName superNovaBlue
hi! link javascriptLabel superNovaFg1
hi! link javascriptObjectLabel superNovaFg1
hi! link javascriptPropertyName superNovaFg1

hi! link javascriptLogicSymbols superNovaFg1
hi! link javascriptArrowFunc superNovaYellow

hi! link javascriptDocParamName superNovaFg4
hi! link javascriptDocTags superNovaFg4
hi! link javascriptDocNotation superNovaFg4
hi! link javascriptDocParamType superNovaFg4
hi! link javascriptDocNamedParamType superNovaFg4

hi! link javascriptBrackets superNovaFg1
hi! link javascriptDOMElemAttrs superNovaFg1
hi! link javascriptDOMEventMethod superNovaFg1
hi! link javascriptDOMNodeMethod superNovaFg1
hi! link javascriptDOMStorageMethod superNovaFg1
hi! link javascriptHeadersMethod superNovaFg1

hi! link javascriptAsyncFuncKeyword superNovaRed
hi! link javascriptAwaitFuncKeyword superNovaRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword superNovaAqua
hi! link jsExtendsKeyword superNovaAqua
hi! link jsExportDefault superNovaAqua
hi! link jsTemplateBraces superNovaAqua
hi! link jsGlobalNodeObjects superNovaFg1
hi! link jsGlobalObjects superNovaFg1
hi! link jsFunction superNovaAqua
hi! link jsFuncParens superNovaFg3
hi! link jsParens superNovaFg3
hi! link jsNull superNovaPurple
hi! link jsUndefined superNovaPurple
hi! link jsClassDefinition superNovaYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved superNovaAqua
hi! link typeScriptLabel superNovaAqua
hi! link typeScriptFuncKeyword superNovaAqua
hi! link typeScriptIdentifier superNovaOrange
hi! link typeScriptBraces superNovaFg1
hi! link typeScriptEndColons superNovaFg1
hi! link typeScriptDOMObjects superNovaFg1
hi! link typeScriptAjaxMethods superNovaFg1
hi! link typeScriptLogicSymbols superNovaFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects superNovaFg1
hi! link typeScriptParens superNovaFg3
hi! link typeScriptOpSymbols superNovaFg3
hi! link typeScriptHtmlElemProperties superNovaFg1
hi! link typeScriptNull superNovaPurple
hi! link typeScriptInterpolationDelimiter superNovaAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword superNovaAqua
hi! link purescriptModuleName superNovaFg1
hi! link purescriptWhere superNovaAqua
hi! link purescriptDelimiter superNovaFg4
hi! link purescriptType superNovaFg1
hi! link purescriptImportKeyword superNovaAqua
hi! link purescriptHidingKeyword superNovaAqua
hi! link purescriptAsKeyword superNovaAqua
hi! link purescriptStructure superNovaAqua
hi! link purescriptOperator superNovaBlue

hi! link purescriptTypeVar superNovaFg1
hi! link purescriptConstructor superNovaFg1
hi! link purescriptFunction superNovaFg1
hi! link purescriptConditional superNovaOrange
hi! link purescriptBacktick superNovaOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp superNovaFg3
hi! link coffeeSpecialOp superNovaFg3
hi! link coffeeCurly superNovaOrange
hi! link coffeeParen superNovaFg3
hi! link coffeeBracket superNovaOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter superNovaGreen
hi! link rubyInterpolationDelimiter superNovaAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier superNovaRed
hi! link objcDirective superNovaBlue

" }}}
" Go: {{{

hi! link goDirective superNovaAqua
hi! link goConstants superNovaPurple
hi! link goDeclaration superNovaRed
hi! link goDeclType superNovaBlue
hi! link goBuiltins superNovaOrange

" }}}
" Lua: {{{

hi! link luaIn superNovaRed
hi! link luaFunction superNovaAqua
hi! link luaTable superNovaOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp superNovaFg3
hi! link moonExtendedOp superNovaFg3
hi! link moonFunction superNovaFg3
hi! link moonObject superNovaYellow

" }}}
" Java: {{{

hi! link javaAnnotation superNovaBlue
hi! link javaDocTags superNovaAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen superNovaFg3
hi! link javaParen1 superNovaFg3
hi! link javaParen2 superNovaFg3
hi! link javaParen3 superNovaFg3
hi! link javaParen4 superNovaFg3
hi! link javaParen5 superNovaFg3
hi! link javaOperator superNovaOrange

hi! link javaVarArg superNovaGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter superNovaGreen
hi! link elixirInterpolationDelimiter superNovaAqua

hi! link elixirModuleDeclaration superNovaYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition superNovaFg1
hi! link scalaCaseFollowing superNovaFg1
hi! link scalaCapitalWord superNovaFg1
hi! link scalaTypeExtension superNovaFg1

hi! link scalaKeyword superNovaRed
hi! link scalaKeywordModifier superNovaRed

hi! link scalaSpecial superNovaAqua
hi! link scalaOperator superNovaFg1

hi! link scalaTypeDeclaration superNovaYellow
hi! link scalaTypeTypePostDeclaration superNovaYellow

hi! link scalaInstanceDeclaration superNovaFg1
hi! link scalaInterpolation superNovaAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 superNovaGreenBold
hi! link markdownH2 superNovaGreenBold
hi! link markdownH3 superNovaYellowBold
hi! link markdownH4 superNovaYellowBold
hi! link markdownH5 superNovaYellow
hi! link markdownH6 superNovaYellow

hi! link markdownCode superNovaAqua
hi! link markdownCodeBlock superNovaAqua
hi! link markdownCodeDelimiter superNovaAqua

hi! link markdownBlockquote superNovaGray
hi! link markdownListMarker superNovaGray
hi! link markdownOrderedListMarker superNovaGray
hi! link markdownRule superNovaGray
hi! link markdownHeadingRule superNovaGray

hi! link markdownUrlDelimiter superNovaFg3
hi! link markdownLinkDelimiter superNovaFg3
hi! link markdownLinkTextDelimiter superNovaFg3

hi! link markdownHeadingDelimiter superNovaOrange
hi! link markdownUrl superNovaPurple
hi! link markdownUrlTitleDelimiter superNovaGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType superNovaYellow
" hi! link haskellOperators superNovaOrange
" hi! link haskellConditional superNovaAqua
" hi! link haskellLet superNovaOrange
"
hi! link haskellType superNovaFg1
hi! link haskellIdentifier superNovaFg1
hi! link haskellSeparator superNovaFg1
hi! link haskellDelimiter superNovaFg4
hi! link haskellOperators superNovaBlue
"
hi! link haskellBacktick superNovaOrange
hi! link haskellStatement superNovaOrange
hi! link haskellConditional superNovaOrange

hi! link haskellLet superNovaAqua
hi! link haskellDefault superNovaAqua
hi! link haskellWhere superNovaAqua
hi! link haskellBottom superNovaAqua
hi! link haskellBlockKeywords superNovaAqua
hi! link haskellImportKeywords superNovaAqua
hi! link haskellDeclKeyword superNovaAqua
hi! link haskellDeriving superNovaAqua
hi! link haskellAssocType superNovaAqua

hi! link haskellNumber superNovaPurple
hi! link haskellPragma superNovaPurple

hi! link haskellString superNovaGreen
hi! link haskellChar superNovaGreen

" }}}
" Json: {{{

hi! link jsonKeyword superNovaGreen
hi! link jsonQuote superNovaGreen
hi! link jsonBraces superNovaFg1
hi! link jsonString superNovaFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! s:superNovaHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! s:superNovaHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
