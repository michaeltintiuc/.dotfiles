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
set exrc
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

" Spelunker
set nospell

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

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neoinclude.vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
" Plug 'zchee/deoplete-jedi'
" Plug 'zchee/deoplete-go', { 'do': 'make'}
" Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" Plug 'zchee/deoplete-clang'
" Plug 'carlitux/deoplete-ternjs'
Plug 'ap/vim-buftabline'
Plug 'matze/vim-move'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'Shougo/echodoc.vim'
" Plug 'StanAngeloff/php.vim'
Plug 'mattn/emmet-vim'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'edkolev/tmuxline.vim'
Plug 'jwalton512/vim-blade'
" Plug 'kchmck/vim-coffee-script'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'posva/vim-vue'
" Plug 'neomake/neomake'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx', 'vue'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'ludovicchabant/vim-gutentags', { 'for': ['c', 'c++'] }
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'calviken/vim-gdscript3'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'nikvdp/ejs-syntax'
Plug 'habamax/vim-godot'
Plug 'dart-lang/dart-vim-plugin'
Plug 'kamykn/spelunker.vim'
Plug 'othree/html5.vim'
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
    \   'gitbranch': 'FugitiveHead'
    \ },
\ }
let g:blamer_enabled = 1
let g:blamer_relative_time = 1

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
" let g:deoplete#sources#ternjs#types = 1
" let g:deoplete#sources#ternjs#filetypes = [
    " \ 'jsx',
    " \ 'javascript.jsx',
    " \ 'vue',
    " \ 'typescript'
" \]
" let g:vue_disable_pre_processors=1
" let g:deoplete#omni#input_patterns = {}
" let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
" let g:deoplete#omni#functions = {}
" let g:deoplete#omni#functions.javascript = [
	" \ 'tern#Complete',
	" \ 'jspc#omni',
" \]
"
" "Go Configs
" let g:deoplete#sources#go#package_dot = 1
" let g:deoplete#sources#go#pointer = 1
let g:go_term_mode = "split"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_auto_type_info = 0
let g:go_auto_sameids = 0
let g:go_fmt_command = "goimports"

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" C/C++
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-8/lib/libclang.so.1'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-8/lib/clang/8.0.0'

" Python
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" Autocomplete
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#skip_chars = ['$']
" let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources#padawan#add_parentheses = 1
"let g:deoplete#sources#padawan#auto_update = 1

" Comments
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Copy to X
set clipboard+=unnamedplus
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
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>
nnoremap <C-p> :FZF<cr>
nnoremap <leader><Enter> :FZFMru<CR>
nnoremap <leader>cf :let @+=expand("%")<CR>
nnoremap <leader>t :exec("Tags " . expand("<cword>"))<CR>
nnoremap <leader>bd :bufdo bd<CR>
nnoremap <leader>c :bd<CR>
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
au BufRead,BufNewFile *.js,*.ts,*.vue,*.tsx,*.scss,*.ejs,*.json setl sw=2 sts=2 et
au BufRead,BufNewFile *.coffee,*.sass setl noexpandtab
autocmd FileType scss setl iskeyword+=@-@

" au BufNewFile,BufRead *.ejs set filetype=javascript.jsx

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" JSX
let g:jsx_ext_required = 0

autocmd FileType json syntax match Comment +\/\/.\+$+

" C/C++
au BufRead,BufNewFile *.c,*.cpp,*.h setl sw=2 sts=2 et

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
"
" if OnBattery()
  " call neomake#configure#automake('w')
" else
  " call neomake#configure#automake('nrwi', 500)
" endif

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>rf  <Plug>(coc-format-selected)
nmap <leader>rf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Go to
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Vista
let g:vista_default_executive = "coc"
let g:vista_executive_for = {
  \ 'rust': 'ctags',
  \ }
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" Dart
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

let g:godot_executable = "/usr/bin/godot -d"
func! GodotSettings() abort
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript,gdshader,gdshaderinc call GodotSettings()
augroup end
