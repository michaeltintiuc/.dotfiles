let mapleader=','
filetype plugin indent on
syntax enable

" Nvim settings
set number
set bs=indent,eol,start
set relativenumber
set ruler
set mouse=a
set autowrite
set autoread
set noshowmode
set hidden
set nojoinspaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smartindent
set pumheight=15
set completeopt=menuone,longest
set list
set listchars=tab:\ \ ,trail:•,extends:#,nbsp:.
set foldmethod=indent
set foldlevelstart=99
set incsearch
set cursorline
set synmaxcol=2048
set lazyredraw
set updatetime=100
set termguicolors
set clipboard+=unnamedplus

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" always show signcolumns
set signcolumn=yes

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c


vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Key mapping
map <leader>l :nohlsearch<cr>
imap jk <ESC>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>
inoremap ;; <C-o>A;
inoremap ,, <C-o>A,
nnoremap ;; A;<Esc>
nnoremap ,, A,<Esc>

hi MatchParen cterm=bold ctermbg=white ctermfg=darkRed
hi IncSearch cterm=bold,underline ctermbg=none ctermfg=darkRed
hi Search cterm=bold,underline ctermbg=none ctermfg=darkRed
hi CursorLineNr term=bold ctermfg=white gui=bold guifg=white
