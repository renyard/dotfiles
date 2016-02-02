set nocompatible
filetype off

" Get the path of the this script.
let s:root = expand("<sfile>:h")

" set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/vim/vundle
call vundle#begin()

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'renyard/vim-git-flow-format'
Plugin 'renyard/vim-rangerexplorer'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rsi'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mhinz/vim-signify'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'rizzatti/dash.vim'
Plugin 'neilagabriel/vim-geeknote'
Plugin 'Raimondi/delimitMate'
Plugin 'pangloss/vim-javascript'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dkprice/vim-easygrep'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

" tmux integration
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'

" Depends on http://ctags.sourceforge.net/ and https://github.com/ramitos/jsctags for JS.
Plugin 'majutsushi/tagbar'
Plugin 'ternjs/tern_for_vim'

" Libraries required by other plugins.
Plugin 'xolox/vim-misc'
Plugin 'rizzatti/funcoo.vim'

" Colour scheme
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin on

if !system("uname -s") =~ "Darwin"
    " Not running on OS X.
    " Use 256 colour palette, as we can't guarantee the terminal theme.
    let g:solarized_termcolors=256
endif

syntax on
set background=dark
colorscheme solarized

" Font and text size.
set guifont=Monaco:h12

if has("gui_running")
    " Set window size for MacVim/GVim.
    set lines=60 columns=120

    " Hide toolbar.
    set guioptions-=T

    " Hide scroll bars.
    set guioptions-=r
    set guioptions-=L

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

" Misc. Options.
set hidden
set fileformats=unix,dos,mac
setglobal fileformat=unix
set tabstop=4
set shiftwidth=4
set expandtab
set number
set incsearch
set hlsearch
set nopaste
set showcmd
set confirm
set laststatus=2
set whichwrap-=<,>,[,],h,l,~
set backspace=indent,eol,start
set noswapfile
set ignorecase

" Check for file changes when focusing Vim.
set autoread

" Indentation.
set autoindent
filetype plugin indent on

" Current line highlight.
set cursorline
:highlight CursorLine cterm=none ctermbg=237

" Enable the mouse in terminal mode.
set mouse=a

" Enable project specific .vimrc files.
set exrc
set secure

" Soft wrap on word boundaries.
set wrap
set linebreak

" Create the directory for storing undo files.
silent !mkdir -p ~/.vim/undo/
set undofile
set undodir=~/.vim/undo/
set undolevels=1000
set undoreload=10000

" Path Completion.
set wildmode=longest,list,full
set wildmenu

" Files to ignore in path completion.
set wildignore+=*/node_modules/*,*\\node_modules\\*
set wildignore+=*/bower_components/*,*\\bower_components\\*
set wildignore+=*/dist/*,*\\dist\\*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_Store " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe        " Windows

" Sometimes we can't avoid Windows, attempt to make usable under Cygwin.
" set term=builtin_ansi

" Spell Checking.
set spell spelllang=en_gb
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad gui=underline term=underline cterm=underline
hi SpellCap gui=underline term=underline cterm=underline
hi SpellRare gui=underline term=underline cterm=underline
hi SpellLocal gui=underline term=underline cterm=underline

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
" autocmd BufEnter,BufFilePost * call SetTitle()

" Syntastic config.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Toggles maximize and return to split window layout.
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
    if exists("s:maximize_session")
        exec "source " . s:maximize_session
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        exec "mksession! " . s:maximize_session
        only
    endif
endfunction

" Native feature key bindings.

" Navigation
map! <C-b> <Left>
map! <C-f> <Right>

" Go to first non-whitespace and end of line.
map! <C-a> <Esc>I
map! <C-e> <Esc>A

" Delete to the end of the line.
map! <C-k> <Esc>l"_d$a
" map! <S-C-K> <Esc>"_ddi

" Move between buffers.
map <C-Tab> :bn<CR>
map <C-S-Tab> :bp<CR>
map gn :bnext<CR>
map gp :bprev<CR>
map <C-k> :bnext<CR>
map <C-j> :bprev<CR>

" Open a horizontal or vertical split.
map <LEADER>- :split<CR>
map <LEADER>\| :vsplit<CR>

" Plugin config & key bindings.

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Turn on tabline.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'

" Don't count trailing whitespace.
let g:airline#extensions#whitespace#enabled = 0

" Only show the tail of the Git branch. e.g. "feature/foo" becomes "foo".
let g:airline#extensions#branch#format = 'Git_flow_branch_format'

" Custom statusline layout. Removes Git status from left to the right of file data.
let g:airline_section_b = ''
let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)} %{airline#util#wrap(airline#parts#ffenc(),0)}'
let g:airline_section_y = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)} %{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

" Dash
map h :Dash<Return>

" ctrlp.vim
map <C-p> :CtrlP<Return>

" Unite
" map <C-p> :Unite file buffer<Return>

" Gundo
let g:gundo_right = 1
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1
nnoremap <C-g> :GundoToggle<CR>

" NERDTree
" nnoremap <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

" netrw
nnoremap <C-o> :Explore<CR>
" Default to tree style view.
let g:netrw_liststyle = 3

" TagBar
nnoremap <C-t> :Tagbar<CR>

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1

set completeopt=longest,menuone
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" UltiSnips
let g:UltiSnipsExpandTrigger = "<C-k>"

" Fugitive
command! Gst Gstatus
command! Gc Gcommit -v
command! Gca Gcommit -av
command! Gd Gvdiff
command! Gl Gpull
command! Gp Gpush

" Session
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
