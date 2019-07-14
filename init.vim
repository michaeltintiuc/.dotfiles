" Autoload Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

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

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-clang'
Plug 'carlitux/deoplete-ternjs'
Plug 'SirVer/ultisnips'
Plug 'sniphpets/sniphpets'
Plug 'sniphpets/sniphpets-common'
Plug 'ap/vim-buftabline'
Plug 'matze/vim-move'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'Shougo/echodoc.vim', {'for': ['php', 'go', 'python']}
Plug 'StanAngeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'edkolev/tmuxline.vim'
Plug 'jwalton512/vim-blade'
Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'posva/vim-vue'
Plug 'neomake/neomake'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue', 'typescript'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'ludovicchabant/vim-gutentags', { 'for': ['c', 'c++'] }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'calviken/vim-gdscript3'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'dbeniamine/cheat.sh-vim'
call plug#end()

" Plugin Configs
let base16colorspace=256
let g:ranger_replace_netrw = 1
let g:tmuxline_powerline_separators = 0
let g:buftabline_show = 1
let g:fzf_mru_relative = 1
let g:echodoc_enable_at_startup=1
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

let s:p = g:lightline#colorscheme#Tomorrow_Night#palette
let s:p.normal.right[0] = s:p.normal.left[0]
let s:p.tabline.right = copy(s:p.normal.right)

" Assembly
autocmd BufNewFile,BufRead *.asm set ft=nasm

"PHP configs
" let g:php_folding = 2

"JS Config
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_map_keys=1
" let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#filetypes = [
    \ 'jsx',
    \ 'javascript.jsx',
    \ 'vue',
    \ 'typescript'
\]
let g:vue_disable_pre_processors=1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
	\ 'tern#Complete',
	\ 'jspc#omni',
\]

"Go Configs
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#pointer = 1
let g:go_term_mode = "split"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" C/C++
let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'

" Snippets
let g:ultisnips_php_scalar_types = 1
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Autocomplete
let g:deoplete#enable_at_startup = 1
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
map <leader>s :source ~/.dotfiles/init.vim<cr>
map <leader>e :e! ~/.dotfiles/init.vim<cr>
map <leader>l :nohlsearch<cr>
map <leader>pi :PlugInstall<cr>
map <F6> :set spell!<cr>
imap jk <ESC>
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <C-p> :FZF<cr>
nnoremap <leader><Enter> :FZFMru<CR>
nnoremap <leader>cf :let @+=expand("%")<CR>
nnoremap <leader>t :exec("Tags " . expand("<cword>"))<CR>
nnoremap <leader>bd :bufdo bd<CR>
inoremap ;; <C-o>A;
inoremap ,, <C-o>A,
nnoremap ;; A;<Esc>
nnoremap ,, A,<Esc>

" Quickfix mapping
" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Go mappings
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" JavaScript
autocmd FileType vue syntax sync fromstart
au BufRead,BufNewFile *.js,*.ts,*.vue setl sw=2 sts=2 et
au BufRead,BufNewFile *.coffee,*.sass setl noexpandtab

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" JSX
let g:jsx_ext_required = 0

" C/C++
au BufRead,BufNewFile *.c,*.cpp,*.h setl sw=2 sts=2 et

" Vuejs
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Misc
" au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
command! PadawanStart call deoplete#sources#padawan#StartServer()
command! PadawanStop call deoplete#sources#padawan#StopServer()
command! PadawanRestart call deoplete#sources#padawan#RestartServer()
command! PadawanInstall call deoplete#sources#padawan#InstallServer()
command! PadawanUpdate call deoplete#sources#padawan#UpdateServer()
command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)

" Colors
colorscheme base16-tomorrow-night

function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

hi MatchParen cterm=bold ctermbg=white ctermfg=darkRed
hi IncSearch cterm=bold,underline ctermbg=none ctermfg=darkRed
hi Search cterm=bold,underline ctermbg=none ctermfg=darkRed
hi CursorLineNr term=bold ctermfg=white gui=bold guifg=white
" hi NonText ctermbg=black ctermfg=lightGrey guibg=black

" PHP doc
augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

"Neomake
" function! neomake#makers#ft#vue#eslint() abort
    " let maker = neomake#makers#ft#javascript#eslint()
    " call extend(get(maker, 'args', []), [])
    " return maker
" endfunction

function! OnBattery()
  return readfile('/sys/class/power_supply/AC/online') == ['0']
endfunction

if OnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nrwi', 500)
endif
