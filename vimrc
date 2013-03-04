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
set laststatus=2
set whichwrap-=<,>,[,],h,l,~
set dir=~/.vim/swp

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

" Completion
set ofu=syntaxcomplete#Complete
