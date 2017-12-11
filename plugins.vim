" Source plug.vim and initialize
exec "source " . expand("<sfile>:h") . "/vim/vim-plug/plug.vim"
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'renyard/vim-git-flow-format'
Plug 'renyard/vim-rangerexplorer', {'on': 'RangerExplorer'}
Plug 'will133/vim-dirdiff'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --js-completer && cd third_party/ycmd/third_party/tern_runtime && rm -rf node_modules && npm install --production'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim', {'on': 'VimFiler'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': ['NERDTree', 'NERDTreeToggle']}
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'janko-m/vim-test'
Plug 'sjl/gundo.vim', {'on': 'Gundo'}
Plug 'Chiel92/vim-autoformat'
Plug 'rizzatti/dash.vim'
Plug 'Raimondi/delimitMate'
Plug 'kshenoy/vim-signature'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" Filetype specific plugins
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

" tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Depends on http://ctags.sourceforge.net/ and https://github.com/ramitos/jsctags for JS.
Plug 'vim-scripts/taglist.vim'
Plug 'xolox/vim-easytags'

" Libraries required by other Plugs.
Plug 'xolox/vim-misc'
Plug 'rizzatti/funcoo.vim'
Plug 'Shougo/vimproc.vim', {'do': ':VimProcInstall'} " Dependency of Shougo/unite.vim

" Colour scheme
Plug 'altercation/vim-colors-solarized'

call plug#end()
