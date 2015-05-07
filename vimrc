" Get the path of the this script.
let s:root = expand("<sfile>:h")

" Set the path to Pathogen and bundles.
let s:pathogen_path = s:root . '/vim/pathogen/autoload/pathogen.vim'
let s:bundle_path = s:root . '/vim/bundle/{}'

let g:pathogen_disabled = ['vimacs', 'vim-signify']

" Initialise Pathogen.
exec "source " s:pathogen_path
call pathogen#infect(s:bundle_path)
filetype plugin on

colorscheme koehler

if has("gui_running")
	" Set window size for MacVim/GVim.
	set lines=60 columns=132

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
set expandtab
set number
set cursorline
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

" When editing a file, make screen display the name of the file you are editing
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

" if has("gui_running")
	" Automatically show NERD tree and close if only NERD tree is open.
	" autocmd vimenter * NERDTree
	" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" Automatically highlight file of current buffer in NERD tree.
	" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
" endif

" Syntastic config.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:VM_Enabled = 1

" Key bindings

" Navigation
map! <C-b> <Left>
map! <C-f> <Right>
"cnoremap <M-f> <S-Right>
"cnoremap <M-b> <S-Left>

" Go to first non-whitespace and end of line.
map! <C-a> <Esc>I
map! <C-e> <Esc>A

" Delete to the end of the line.
map! <C-k> <Esc>l"_d$a
" map! <S-C-K> <Esc>"_ddi

" Dash
map <C-h> :Dash<Return>
