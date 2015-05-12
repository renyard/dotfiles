" Get the path of the this script.
let s:root = expand("<sfile>:h")

" Set the path to Pathogen and bundles.
let s:pathogen_path = s:root . '/vim/pathogen/autoload/pathogen.vim'
let s:bundle_path = s:root . '/vim/bundle/{}'

let g:pathogen_disabled = ['vim-powerline', 'vim-signify']

if has("lua")
    call add(g:pathogen_disabled, 'supertab')
else
    call add(g:pathogen_disabled, 'neocomplete')
    call add(g:pathogen_disabled, 'neosnippet')
endif

" Initialise Pathogen.
exec "source " s:pathogen_path
call pathogen#infect(s:bundle_path)
filetype plugin on

colorscheme koehler

" Font and text size.
set guifont=Monaco:h12

if has("gui_running")
    " Set window size for MacVim/GVim.
    set lines=60 columns=120

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
set cindent
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

" Files to ignore in path completion.
set wildignore+=*/node_modules/*,*\\node_modules\\*
set wildignore+=*/bower_modules/*,*\\bower_modules\\*
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

" Native feature key bindings.

" Navigation
map! <C-b> <Left>
map! <C-f> <Right>
"cnoremap <M-f> <S-Right>
"cnoremap <M-b> <S-Left>

" Go to first non-whitespace and end of line.
map! <C-a> <Esc>I
map! <C-e> <Esc>A

" Move line up and down.
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Delete to the end of the line.
map! <C-k> <Esc>l"_d$a
" map! <S-C-K> <Esc>"_ddi

" Plugin config & key bindings.

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Don't count trailing whitespace.
let g:airline#extensions#whitespace#enabled = 0

let g:airline_section_a = airline#section#create_left(['mode', 'paste', 'capslock', 'iminsert'])
let g:airline_section_b = airline#section#create(['hunks', 'branch'])
let g:airline_section_c = airline#section#create(['%<', 'file', spc, 'readonly'])
let g:airline_section_gutter = airline#section#create(['%='])
let g:airline_section_x = airline#section#create_right(['tagbar', 'filetype'])
let g:airline_section_y = airline#section#create_right(['ffenc'])
let g:airline_section_z = airline#section#create(['windowswap', '%3p%%'.spc, 'linenr', ':%3v '])
let g:airline_section_warning = airline#section#create(['syntastic', 'eclim', 'whitespace'])

" Dash
map <C-h> :Dash<Return>

" ctrlp.vim
map <C-p> :CtrlP<Return>

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Neosnippet
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/vim/bundle/vim-snippets/snippets'
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

" Fugitive
command Gst Gstatus
command Gc Gcommit -v
command Gca Gcommit -av
command Gd Gvdiff
