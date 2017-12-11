" vim: set fdm=marker fmr={{{,}}} fdl=0 :
" System {{{

set nocompatible

filetype off

" Load plugins.
exec "source " . expand("<sfile>:h") . "/plugins.vim"

filetype on
filetype plugin on

if !system("uname -s") =~ "Darwin"
    " Not running on OS X.
    " Use 256 colour palette, as we can't guarantee the terminal theme.
    let g:solarized_termcolors=256
endif

syntax on

" }}}

" GUI Settings {{{

if has("gui_running")
    set background=light

    set guifont=Monaco:h16
    " Set window size for MacVim/GVim.
    set lines=60 columns=80

    " Hide toolbar.
    set guioptions-=T

    " Hide scroll bars.
    set guioptions-=r
    set guioptions-=L

    " Prevent cursor moving to click location on window focus.
    augroup NO_CURSOR_MOVE_ON_FOCUS
        au!
        au FocusLost * let g:oldmouse=&mouse | set mouse=
        au FocusGained * if exists('g:oldmouse') | let &mouse=g:oldmouse | unlet g:oldmouse | endif
    augroup END
endif

" }}}

" Native Vim Opts {{{

" Send all x deletions to the black hole register.
noremap x "_x
vnoremap x "_x

colorscheme solarized

" Misc. Options.
set hidden
set fileformats=unix,dos,mac
setglobal fileformat=unix
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
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

" Improve performance in tmux.
" set lazyredraw

" Check for file changes when focusing Vim.
set autoread

" Indentation.
set autoindent
filetype plugin indent on

" Code folding.
set foldmethod=syntax
set foldlevel=999
" set nofoldenable
nnoremap <Space> za

" Current line highlight.
set cursorline
" highlight CursorLine cterm=none ctermbg=237

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

augroup omnicomplete
  autocmd!
    autocmd FileType javascript setlocal omnifunc=tern#Complete
augroup END

" }}}

" Toggles maximize and return to split window layout {{{

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

" }}}

" Native feature key bindings {{{

" Map § to escape for a bigger target!
imap § <Esc>

" Split navigation.
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

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

" Close the location list on selection.
augroup lclose
    autocmd!
    autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>
augroup END

" }}}

" Plugin config & key bindings {{{

" Airline {{{

" Only enable required extensions.
let g:airline_extensions = ['ale', 'branch', 'unite', 'ycm']

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Short form indication for common modes.
let g:airline_mode_map = {
    \ 'n': 'n',
    \ 'i': 'i',
    \ 'v': 'v'
\ }

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Do not show spell indication.
let g:airline_detect_spell = 0

" Turn on tabline.
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'

" Don't count trailing whitespace.
let g:airline#extensions#whitespace#enabled = 0

" Only show the tail of the Git branch. e.g. "feature/foo" becomes "foo".
let g:airline#extensions#branch#format = 'Git_flow_branch_format'

" Custom statusline layout. Removes Git status from left to the right of file data.
let g:airline_section_b = ''
let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)}'
let g:airline_section_y = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

" }}}

" ALE {{{

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_set_loclist = 0
let g:ale_set_quikfix = 0

" }}}

" dash.vim {{{

:nmap <silent> <LEADER>d <Plug>DashSearch

" }}}

" delimitMate {{{
    let delimitMate_expand_cr = 1
" }}}

" easytags {{{

set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_suppress_report = 1

let g:easytags_languages = {
\   'javascript': {
\     'cmd': 'ctags'
\   }
\}

" }}}

" Indent Guides {{{

if !has("gui_running")
    let g:indent_guides_auto_colors = 0

    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=8
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
endif

let g:indent_guides_enable_on_vim_startup = 1

" }}}

" vim-jsx {{{

" Do not require .jsx extension for JSX syntax.
let g:jsx_ext_required = 0

" }}}

" Unite {{{

call unite#custom#source('buffer', 'converters', 'converter_word_abbr')
call unite#custom#source('file_rec,file_rec/async', 'ignore_globs', ['node_modules/**/*', 'reports/**/*'])

map <C-t> :Unite buffer -no-split<Return>
" if has("lua")
	" This is slow without lua support.
	map <C-p> :Unite file_rec/async -start-insert -no-split<Return>
" endif

if executable('ag')
	" Use ag (the silver searcher)
	" https://github.com/ggreer/the_silver_searcher
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts =
	\ '-i --vimgrep --hidden --ignore ' .
	\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	let g:unite_source_grep_recursive_opt = ''
endif

function! UniteSearch(source, scope, opts, pattern)
	execute 'Unite ' . a:source . ':' . a:scope . ':' . a:opts . ':' . a:pattern
endfunction

" Find in current buffer.
command! -nargs=+ Search call UniteSearch('grep', '%', '', '<args>')
command! -nargs=+ Fsearch call UniteSearch('grep', '%', '-F', '<args>')
" Grep current working directory.
command! -nargs=+ Grep call UniteSearch('grep', '.', '', '<args>')
command! -nargs=+ Fgrep call UniteSearch('grep', '.', '-F', '<args>')

" }}}

" Vim Filer {{{

nnoremap <C-o> :VimFiler<CR>
" Forces VimFiler to close instead of hide.
autocmd FileType vimfiler :autocmd BufLeave <buffer> :bd
let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\|node_modules\)$'

" }}}

" Signify {{{

let g:signify_update_on_focusgained = 1

" }}}

" Gundo {{{

let g:gundo_right = 1
let g:gundo_preview_bottom = 1
let g:gundo_close_on_revert = 1
nnoremap <C-g> :GundoToggle<CR>

" }}}

" NERDTree {{{

" nnoremap <C-o> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1

" }}}

" YouCompleteMe {{{

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" }}}

" deoplete.nvim {{{

let g:deoplete#enable_at_startup = 1

" }}}

" Neocomplete {{{

if has('lua')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_fuzzy_completion = 1
    let g:neocomplete_enable_fuzzy_completion_start_length = 2

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
    function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
else
    let g:neocomplete#enable_at_startup = 0
endif

" }}}

" Neosnippet {{{

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

set completeopt=longest,menuone
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}

" EditorConfig {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}}

" UltiSnips {{{

let g:UltiSnipsExpandTrigger = "<C-k>"

" }}}

" Fugitive {{{

command! -nargs=* Gst Gstatus <f-args>
command! -nargs=* Gc Gcommit -v <f-args>
command! -nargs=* Gca Gcommit -av <f-args>
command! -nargs=* Gd Gvdiff <f-args>
command! -nargs=* Gl Gpull <f-args>
command! -nargs=* Gp Gpush <f-args>

" }}}

" Session {{{

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

" }}}

" Tern {{{

let g:tern_map_keys = 1
let g:tern_show_argument_hints = 'on_hold'

" }}}

" }}}

silent! so .lvimrc
