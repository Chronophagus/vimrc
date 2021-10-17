" Global settings

set nocompatible
set fileencoding=utf8

set wrap
set linebreak
set nolist

set rnu
set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
set preserveindent

set hlsearch
set incsearch
set smartcase
set ignorecase

set showmatch

set mouse=a

set undolevels=1000

set completeopt=longest,menu

set noswapfile

set scrollback=100000

" Mappings

nnoremap j gj
nnoremap k gk

nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap J <C-d>
nnoremap K <C-u>

nnoremap <space> <nop>

nnoremap <Tab> gt
nnoremap <S-Tab> gT

let mapleader=" "
nnoremap <leader>s :w<cr>
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
nnoremap <silent> <leader>[ :bprev!<cr>
nnoremap <silent> <leader>] :bnext!<cr>
nnoremap <leader>j J
nnoremap <leader><leader> <C-^>

vnoremap <leader>y "+y
vnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>Y "+yg_

vnoremap <leader>p "+p
vnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

tnoremap <Esc> <C-\><C-n>
tnoremap ;j <C-\><C-n>

inoremap ;j <esc>
inoremap {<cr> {<cr>}<c-o>O

" Hightlight fix
autocmd CursorMoved * set nohlsearch
nnoremap n n:set hlsearch<cr>
nnoremap N N:set hlsearch<cr>

" Plugins
"
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'ayu-theme/ayu-vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'ryanoasis/vim-devicons'
  Plug 'godlygeek/tabular'
  "Plug 'SirVer/ultisnips'
  "Plug 'honza/vim-snippets'
call plug#end()

" Plugin mappings and settings

" -- NERDTree
nnoremap <leader><Tab> :NERDTreeToggle<cr>

" -- colortheme

set background=dark
set termguicolors
let ayucolor="dark"
colorscheme ayu
hi Error guibg=#870000

" -- fzf
nnoremap <C-p> :Files<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>w :bn<bar>:sp<bar>:bp<bar>:bd<cr>
nnoremap <leader>q :bd!<cr>
 
" -- Vim airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" -- LanguageClient
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
require('rust-tools').setup({})

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'g?', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'g<Tab>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'g&', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" -- Rust Vim

let g:rustfmt_autosave = 1
command! Cc lua require('rust-tools.runnables').runnables()
command! Cb split | te cargo build --release
command! Rcc split | te on-hetzner cargo clippy --tests
command! Rcb split | te on-hetzner cargo build
command! Rcbr split | te on-hetzner cargo build --release
