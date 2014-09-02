" Get the path of the this script.
let s:root = expand("<sfile>:h")

" Set the path to Pathogen and bundles.
let s:pathogen_path = s:root . '/vim/pathogen/autoload/pathogen.vim'
let s:bundle_path = s:root . '/vim/bundle'

" Initialise Pathogen.
exec "source " s:pathogen_path
call pathogen#infect(s:bundle_path)
filetype plugin on

colorscheme koehler

if has("gui_running")
	" Set window size for GVim.
	set lines=60 columns=100

	" Hide toolbar.
	set guioptions -=T

	" Set tranparency. (MacVim specific option)
	if has("transparency")
		set transparency=10
	endif

	" Prevent cursor moving to click location on window focus.
	augroup NO_CURSOR_MOVE_ON_FOCUS
		au!
		au FocusLost * let g:oldmouse=&mouse | set mouse=
		au FocusGained * if exists('g:oldmouse') | let &mouse=g:oldmouse | unlet g:oldmouse | endif
	augroup END
endif

syntax on 

" Misc. Options.
set hidden
set fileformats=unix,dos,mac
setglobal fileformat=unix
set tabstop=4
set shiftwidth=4
set number
set smartindent
set incsearch
set hlsearch
set nopaste
set showcmd
set laststatus=2
set whichwrap-=<,>,[,],h,l,~
set nowrap
set dir=~/.vim/swp
set backspace=indent,eol,start

" Path Completion.
set wildmode=longest,list,full
set wildmenu

" Sometimes we can't avoid Windows, attempt to make usable under Cygwin.
" set term=builtin_ansi

" Spell Checking.
set spell spelllang=en_gb
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad term=underline cterm=underline
hi SpellCap term=underline cterm=underline
hi SpellRare term=underline cterm=underline
hi SpellLocal term=underline cterm=underline

" Mode dependant cursors.
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Completion
set ofu=syntaxcomplete#Complete

"When editing a file, make screen display the name of the file you are editing
function! SetTitle()
  if $TERM =~ "^screen"
    let l:title = 'vim: ' . expand('%:t')        
    
    if (l:title != 'vim: __Tag_List__')
      let l:truncTitle = strpart(l:title, 0, 30)
      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'     
    endif
  endif
endfunction

" Run it every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()
