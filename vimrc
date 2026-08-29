set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set nocompatible
scriptencoding utf-8

" =============================================================================
" Providers
" =============================================================================
let g:python3_host_prog = '/opt/homebrew/bin/python3.11'
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" =============================================================================
" Plugins (vim-plug)
" =============================================================================
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" --- Language & Syntax ---
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vim-ruby/vim-ruby'

" --- LSP & Completion ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- Navigation ---
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'

" --- Editing Utilities ---
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'

" --- Git ---
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" --- UI ---
Plug 'jacoborus/tender'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'

" --- Tmux Integration ---
Plug 'benmills/vimux'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'

" --- Snippets ---
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" --- Search ---
Plug 'rking/ag.vim'

" --- Misc ---
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'tpope/vim-rails'
Plug 'scrooloose/Syntastic'
Plug 'vim-scripts/Vim-R-plugin'

call plug#end()

" =============================================================================
" CoC
" =============================================================================
let g:coc_global_extensions = [
  \ 'coc-lists', 'coc-emmet', 'coc-calc', 'coc-tsserver',
  \ 'coc-snippets', 'coc-html', 'coc-css', 'coc-json',
  \ 'coc-eslint', 'coc-prettier'
  \ ]

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

" CoC keymaps
nnoremap <leader>v :call CocAction("doHover")<cr>
nmap <silent> <C-f> <Plug>(coc-cursors-position)
nmap gd :call CocAction('jumpDefinition', 'drop')<CR>
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>pf <Plug>(coc-format-selected)
vmap <leader>pf <Plug>(coc-format-selected)
nmap <leader>fp :CocCommand prettier.formatFile<CR>
nnoremap <leader>fw :CocSearch<space>

snoremap <C-j> <space>
vnoremap <C-j> <space>
inoremap <expr> <C-l> pumvisible() ? "\<C-n>" : "\<left>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" =============================================================================
" UI & Appearance
" =============================================================================
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
else
  let &t_8f = "\e[38;2;%ld;%ld;%ldm"
  let &t_8b = "\e[48;2;%ld;%ld;%ldm"
  set termguicolors
endif

if has("syntax")
  syntax on
endif

colorscheme tender
set number
set relativenumber
set cursorline
set laststatus=2

highlight Visual cterm=NONE ctermbg=8 ctermfg=NONE guibg=Grey40

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
function! AirlineInit()
  let g:airline_section_a = airline#section#create([])
  let g:airline_section_y = airline#section#create([])
  let g:airline_section_z = airline#section#create([])
endfunction
autocmd VimEnter * call AirlineInit()

" IndentLine
let g:indentLine_color_term = 8
let g:indentLine_char = '│'

" Tmuxline
let g:tmuxline_preset = {
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W '],
      \'y'    : ['%A', '%H:%M', '%Y-%m-%d'],
      \'z'    : '#h'}

" =============================================================================
" Editor Settings
" =============================================================================
set mouse=a
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set backspace=indent,eol,start
set clipboard=unnamed

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" =============================================================================
" NERDTree & Startify
" =============================================================================
let g:NERDTreeWinSize = 25
let g:startify_change_to_vcs_root = 1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
autocmd VimEnter * NERDTree | wincmd p

" =============================================================================
" Plugin Settings
" =============================================================================

" DelimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1

" Surround — {/* */} wrapper on <leader>t in JSX
let g:surround_116 = "{/* \r */}"

" SnipMate
let g:snipMate = get(g:, 'snipMate', {})
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

" JSX in plain .js files
let g:jsx_ext_required = 0

" Closetag
let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"

" =============================================================================
" Key Mappings
" =============================================================================

" --- File Navigation ---
nnoremap <C-p> :exe 'CocList files ' . trim(system('git rev-parse --show-toplevel 2>/dev/null \|\| pwd'))<CR>
nnoremap <C-[> :exe 'CocList files ' . trim(system('git rev-parse --show-toplevel 2>/dev/null \|\| pwd'))<CR>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>

" --- Buffers ---
nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

" --- Editing ---
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <Up> kddpk
nnoremap <Down> ddp
nnoremap <CR> o<ESC>
nnoremap <C-z> a
inoremap ß <ESC>:w<CR>
imap ;w <ESC>:w<CR>
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>

" --- Insert Mode Navigation (macOS Option key combos) ---
inoremap ˙ <C-o>h
inoremap ∆ <C-o>gj
inoremap ˚ <C-o>gk
inoremap ¬ <C-o>l
inoremap ∑ <C-o>w
inoremap ∫ <C-o>b
inoremap … <ESC>
vnoremap … <ESC>
cnoremap … <ESC>

" --- Named Register Shortcuts ---
vnoremap a "jy
vnoremap z "ky
vnoremap x "ly
nnoremap å "jp
nnoremap Ω "kp
nnoremap ≈ "lp

" --- EasyMotion ---
map <Leader>f <Plug>(easymotion-bd-f)

" --- Number Toggle ---
function! NumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>z :call NumberToggle()<cr>

" --- Vimux Runner ---
function! P_Compile()
  let i = expand('%:e')
  if ( i == "rb" || i == 'js' || i == 'py' )
    return c
  else
    let c = " echo lol no compiler found "
    return c
  endif
endfunc

nmap <leader>x   :w \| call VimuxRunCommand(P_Compile()) <CR>
nmap <leader>r   :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>r   :call VimuxRunCommand(getline('.') ." ") <CR>
nmap <leader>t   :w \| call VimuxRunCommand("!!") \| call VimuxSendKeys('enter') <CR>
nmap <Leader>cc  :call VimuxInterruptRunner()<CR>
nmap <leader>e   :call VimuxRunCommand("exit") <CR>
nmap <leader>ee  :call VimuxRunCommand("exit! ") <CR>
nmap <leader>npm :w \| call VimuxRunCommand("npm run bundle ") <CR>
nmap <leader>py  :call VimuxRunCommand("python -m SimpleHTTPServer") <CR>

" --- Ruby / Rails ---
nmap <leader>dd  :w \| call VimuxRunCommand("bundle install") <CR>
nmap <leader>rf  :w \| call VimuxRunCommand("rspec --f-f") <CR>
nmap <leader>rs  :w \| call VimuxRunCommand("rspec") <CR>
nmap <leader>Q   :w \| call VimuxRunCommand("rspec " .expand('%:p:h'). "/../spec/*" .expand('%:t:r')."*") <CR>
nmap <leader>1s  :w \| call VimuxRunCommand("rspec" .expand('%:p'). ":".line('.')) <CR>
nmap <leader>pry :call VimuxRunCommand("pry") <CR>
nmap <leader>db  :call VimuxRunCommand("cat db/schema.rb") <CR>
nmap <leader>rr  :call VimuxRunCommand("rake routes") <CR>
nmap <leader>et  :call VimuxRunCommand("rake db:migrate RAILS_ENV=test") <CR>

" =============================================================================
" Local Overrides
" =============================================================================
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
