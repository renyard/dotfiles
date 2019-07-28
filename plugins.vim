" Source plug.vim and initialize
exec "source " . expand("<sfile>:h") . "/vim/vim-plug/plug.vim"
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'renyard/vim-git-flow-format'
" Plug 'renyard/vim-rangerexplorer', {'on': 'RangerExplorer'}
" Plug 'will133/vim-dirdiff'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rsi'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/vimfiler.vim', {'on': 'VimFiler'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind']}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': ['NERDTree', 'NERDTreeToggle']}
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
" Plug 'sjl/gundo.vim', {'on': 'Gundo'}
" Plug 'Chiel92/vim-autoformat'
" Plug 'rizzatti/dash.vim'
Plug 'Raimondi/delimitMate'
" Plug 'kshenoy/vim-signature'
" Plug 'rking/ag.vim'

" Plug 'Shougo/deol.nvim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" UI
Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Session
" Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" Buffer Management
Plug 'qpkorr/vim-bufkill'

" Javascript
Plug 'moll/vim-node'
Plug 'myhere/vim-nodejs-complete'

" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'junegunn/gv.vim'

" Testing
" Plug 'janko-m/vim-test'
" Plug 'ruanyl/coverage.vim'

" Unite/Denite
" Plug 'Shougo/unite.vim'
Plug 'Shougo/denite.nvim', {'do': 'pip3 install --user pynvim'}
" Plug 'chemzqm/vim-easygit'
" Plug 'chemzqm/denite-git'
" Plug 'chemzqm/unite-location'
" Plug 'Shougo/unite-outline'

" Filetype specific plugins
" Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
" Plug 'Quramy/tsuquyomi'
" Plug 'mxw/vim-jsx'
" Plug 'elzr/vim-json'
" Plug 'iamcco/markdown-preview.vim'
" Plug 'ap/vim-css-color'
" Plug 'plasticboy/vim-markdown'

" tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

" Libraries required by other Plugs.
Plug 'rizzatti/funcoo.vim'
" Plug 'Shougo/vimproc.vim', {'do': ':VimProcInstall'} " Dependency of Shougo/unite.vim
Plug 'roxma/nvim-yarp' " Dependency of denite
Plug 'roxma/vim-hug-neovim-rpc' " Dependency of denite
" Plug 'godlygeek/tabular' " Dependency of vim-markdown

" Colour scheme
Plug 'altercation/vim-colors-solarized'

call plug#end()
