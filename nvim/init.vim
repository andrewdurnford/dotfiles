" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" VimPlug
call plug#begin('~/.config/nvim/plugins')

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'norcalli/nvim-colorizer.lua'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Misc
Plug 'gruvbox-community/gruvbox'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lewis6991/foldsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lualine/lualine.nvim'
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

let g:gruvbox_contrast_dark="hard"
let g:gruvbox_invert_selection="0"
colorscheme gruvbox

" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

" Fix gruvbox highlight groups when using hard contrast
hi SignColumn guibg=none
highlight! link GitSignsAdd GruvboxGreen
highlight! link GitSignsChange GruvboxYellow
highlight! link GitSignsDelete GruvboxRed
highlight! link GitSignsChangeDelete GruvboxYellow

" Fix treesitter using clashing highlight groups with gruvbox in some languages

" typescriptreact
highlight! link tsxTSConstructor GruvboxYellowBold
highlight! link tsxTSTag GruvboxYellow
highlight! link tsxTSTagDelimiter GruvboxAqua
highlight! link tsxTSPunctBracket GruvboxBlue
" ISSUE: https://github.com/tree-sitter/tree-sitter-typescript/issues/200
highlight! link tsxTSConditional NormalNC
highlight! link tsxTSInclude GruvboxPurple
highlight! link tsxTSParameter SignColumn
highlight! link tsxTSVariable SignColum
highlight! link tsxTSParameter SignColum
highlight! link tsxTSOperator GruvboxPurple
highlight! link tsxTSProperty GruvboxAqua
highlight! link tsxTSConstant GruvboxBlueBold

" TODO: typescript

" javascript / javascriptreact
highlight! link javascriptTSConstructor GruvboxYellow
highlight! link javascriptTSTag GruvboxYellow
highlight! link javascriptTSTagDelimiter GruvboxAqua
highlight! link javascriptTSPunctBracket GruvboxBlue
highlight! link javascriptTSNamespace GruvboxBlue
highlight! link javascriptTSProperty GruvboxAqua

" todo comments
highlight! link commentTSNote GruvboxFg0
highlight! link commentTSWarning GruvboxFg0
highlight! link commentTSDanger DiagnosticError
highlight! link commentTSPunctDelimiter GruvboxBlue

" TODO: prisma

" Set .js files as javascriptreact
augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeQuitOnOpen=1

nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" -----------------------------------------------------------------------------
" FZF
" -----------------------------------------------------------------------------

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-n> :silent !tmux neww tmux-sessionizer<CR>

" -----------------------------------------------------------------------------
" git
" -----------------------------------------------------------------------------

noremap <leader>gc :GBranches<CR>
noremap <leader>gs :G<CR>
noremap <leader>gp :Git push -u origin HEAD<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>

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
lua require("user.treesitter")
