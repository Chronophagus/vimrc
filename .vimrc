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

" Mappings

nnoremap j gj
nnoremap k gk

nnoremap m ,
nnoremap , ;
nnoremap ; <nop>

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
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Optional
  Plug 'vim-airline/vim-airline'
call plug#end()

" Plugin mappings and settings

" -- NERDTree
nnoremap <leader><Tab> :NERDTreeToggle<cr>

" -- gruvbox

colorscheme gruvbox8
set background=light

" -- fzf
nnoremap <C-p> :Files<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Rg<cr>
nnoremap <leader>w :bn<bar>:sp<bar>:bp<bar>:bd<cr>
nnoremap <leader>q :bd!<cr>

" -- CoC
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" -- Vim airline
let g:airline#extensions#coc#enabled = 0
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
