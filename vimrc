" Get the path of the this script.
let s:root = expand("<sfile>:h")

" Set the path to Pathogen and bundles.
let s:pathogen_path = s:root . '/vim/pathogen/autoload/pathogen.vim'
let s:bundle_path = s:root . '/vim/bundle'

" Initialise Pathogen.
exec "source " s:pathogen_path
call pathogen#infect(s:bundle_path)
filetype plugin on

" Set theme and window size for GVIM.
if has("gui_running")
	colorscheme koehler
	set lines=60 columns=100
endif

syntax on 

set tabstop=4
set number
set smartindent
set spell
set nopaste

" Completion
set ofu=syntaxcomplete#Complete

