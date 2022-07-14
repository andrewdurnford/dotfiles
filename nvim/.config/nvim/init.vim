" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Set filetype for jsonc files
autocmd BufNewFile,BufRead package.json setlocal filetype=jsonc
autocmd BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc

" VimPlug
call plug#begin('~/.config/nvim/plugins')

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'MunifTanjim/prettier.nvim'
Plug 'b0o/schemastore.nvim'

" Completions
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'L3MON4D3/LuaSnip'

" Highlighting
Plug 'navarasu/onedark.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Misc
Plug 'lewis6991/gitsigns.nvim'
Plug 'lewis6991/foldsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()

" -----------------------------------------------------------------------------
" Theme
" -----------------------------------------------------------------------------

syntax on
set t_Co=256
set termguicolors
set background=dark

colorscheme onedark

" Set .js files as javascriptreact
augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

" Resize splits when screen size changes automatically
autocmd VimResized * wincmd =

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeQuitOnOpen=1

nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" -----------------------------------------------------------------------------
" FZF / Telescope
" -----------------------------------------------------------------------------

" NOTE: use `:e .env` to open env files which are hidden in .gitignore
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <silent> <C-n> :silent !tmux neww tmux-sessionizer<cr>

" -----------------------------------------------------------------------------
" git
" -----------------------------------------------------------------------------

" TODO: merge conflicts
" nmap <leader>gh :diffget //2<CR>
" nmap <leader>gl :diffget //3<CR>

nnoremap <silent> <Leader>gf :exec "Git push -f"<cr>
nnoremap <silent> <Leader>gp :exec "Git push origin " . fugitive#head()<cr>
map <ca> !GIT_COMMITTER_DATE="$(git log -n 1 --format=%aD)" git commit --amend --date="$(git log -n 1 --format=%aD)"<cr>

" -----------------------------------------------------------------------------
" Settings
" -----------------------------------------------------------------------------

let mapleader = " "

syntax enable
filetype plugin on
filetype indent on

set laststatus=2
set linebreak
set textwidth=80
set autoindent
set smartindent
set expandtab
set tabstop=4 softtabstop=4
set shiftwidth=4

set nofoldenable
set foldnestmax=1

" set ignorecase
" set showmatch

set encoding=utf-8

set guicursor=
" set relativenumber
" set nohlsearch
" set incsearch
set autoread
set hidden
set noerrorbells
set number
set nowrap
set noswapfile
set nobackup
set nowritebackup
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set isfname+=@-@
set splitbelow splitright

" Give more space for displaying messages
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

lua require("user.autopairs")
lua require("user.colorizer")
lua require("user.gitsigns")
lua require("user.lsp-config")
lua require("user.lualine")
lua require("user.onedark")
lua require("user.telescope")
lua require("user.treesitter")
