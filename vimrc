" Autoload Plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	 autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader=','
filetype plugin indent on
syntax enable

" Vim settings
set number
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
set laststatus=2

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'SirVer/ultisnips'
Plug 'ap/vim-buftabline'
Plug 'matze/vim-move'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'Shougo/echodoc.vim', { 'for': ['php'] }
Plug 'StanAngeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'edkolev/tmuxline.vim'
Plug 'jwalton512/vim-blade'
Plug 'leafgarland/typescript-vim'
call plug#end()

" Plugin Configs
let base16colorspace=256
let g:tmuxline_powerline_separators = 0
let g:buftabline_show = 1
let g:fzf_mru_relative = 1
" let g:echodoc_enable_at_startup=1
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night',
	\ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head'
	\ },
	\ }

"PHP configs
"let g:php_folding = 2

" Snippets
let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/vim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Autocomplete
" let g:deoplete#enable_at_startup = 1
let g:deoplete#skip_chars = ['$']
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#padawan#add_parentheses = 1
"let g:deoplete#sources#padawan#auto_update = 1

" Comments
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Copy to X
set clipboard+=unnamed
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>d "+d
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Key mapping
inoremap <expr> <TAB> pumvisible() ?  "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ?  "\<C-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ?  "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <C-p> :FZF<cr>
nnoremap <leader><Enter> :FZFMru<CR>
nnoremap <C-\> :NERDTreeToggle<CR>

" Misc
" au BufWritePost *.php silent!  !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
command! PadawanStart call deoplete#sources#padawan#StartServer()
command! PadawanStop call deoplete#sources#padawan#StopServer()
command! PadawanRestart call deoplete#sources#padawan#RestartServer()
command! PadawanInstall call deoplete#sources#padawan#InstallServer()
command! PadawanUpdate call deoplete#sources#padawan#UpdateServer()
command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)

" Colors
colorscheme base16-tomorrow-night

function!  PhpSyntaxOverride()
	hi!  def link phpDocTags phpDefine
	hi!  def link phpDocParam phpType
endfunction

" PHP doc
augroup phpSyntaxOverride
	autocmd!
	autocmd FileType php call PhpSyntaxOverride()
augroup END
