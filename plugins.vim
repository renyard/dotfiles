" set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/vim/vundle
call vundle#begin()

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'renyard/vim-git-flow-format'
Plugin 'renyard/vim-rangerexplorer'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rsi'
Plugin 'shougo/neocomplete.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'Shougo/neoyank.vim'
Plugin 'mhinz/vim-signify'
Plugin 'Konfekt/FastFold'
Plugin 'w0rp/ale'
Plugin 'sjl/gundo.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rizzatti/dash.vim'
Plugin 'Raimondi/delimitMate'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

" Filetype specific plugins
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'leafgarland/typescript-vim'
" Plugin 'Quramy/tsuquyomi'

" tmux integration
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'christoomey/vim-tmux-navigator'

" Depends on http://ctags.sourceforge.net/ and https://github.com/ramitos/jsctags for JS.
Plugin 'majutsushi/tagbar'
Plugin 'xolox/vim-easytags'
Plugin 'ternjs/tern_for_vim'

" Libraries required by other plugins.
Plugin 'xolox/vim-misc'
Plugin 'rizzatti/funcoo.vim'
Plugin 'Shougo/vimproc.vim' " Dependency of Shougo/unite.vim

" Colour scheme
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
