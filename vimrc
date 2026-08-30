set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set nocompatible
scriptencoding utf-8

" =============================================================================
" Providers
" =============================================================================
" Point to the exact python3 binary so :checkhealth doesn't warn about it
let g:python3_host_prog = '/opt/homebrew/bin/python3.11'
" Disable unused providers to suppress health warnings and skip their startup cost
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0

" =============================================================================
" Plugins (vim-plug)
" =============================================================================
" Auto-install vim-plug if it's missing
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
Plug 'sheerun/vim-polyglot'                                              " broad syntax support (JS, TS, JSX, etc.)
Plug 'ap/vim-css-color'                                                  " inline color previews in CSS/Sass
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }    " syntax for styled-components template literals
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby'] }                  " lazy-loaded ruby support

" --- LSP & Completion ---
Plug 'neoclide/coc.nvim', {'branch': 'release'}                         " LSP client, completion, diagnostics

" --- Navigation ---
Plug 'easymotion/vim-easymotion'                                         " jump to any visible word with <leader>f
Plug 'christoomey/vim-tmux-navigator'                                    " C-h/j/k/l moves between vim splits and tmux panes seamlessly
Plug 'scrooloose/nerdtree'                                               " file explorer sidebar
Plug 'mhinz/vim-startify'                                                " start screen with recent files

" --- Editing Utilities ---
Plug 'tpope/vim-surround'                                                " cs, ds, ys to change/delete/add surrounding chars
Plug 'tpope/vim-repeat'                                                  " makes . repeat vim-surround and other plugin operations
Plug 'tpope/vim-commentary'                                              " gc to toggle comments
Plug 'Raimondi/delimitMate'                                              " auto-closes brackets, quotes, parens
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }                        " lazy: align text by delimiter

" --- Git ---
Plug 'tpope/vim-fugitive'                                                " Git commands inside vim (:Git blame, :Git diff, etc.)
Plug 'tpope/vim-rhubarb'                                                 " extends fugitive with GitHub URLs (:GBrowse)
Plug 'airblade/vim-gitgutter'                                            " shows git diff markers in the sign column

" --- UI ---
Plug 'jacoborus/tender'                                                  " color scheme
Plug 'vim-airline/vim-airline'                                           " status/tabline
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'                                               " vertical indent guides
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }                      " lazy: ctags-based symbol browser

" --- Tmux Integration ---
Plug 'benmills/vimux'                                                    " run commands in a tmux pane from vim
Plug 'edkolev/tmuxline.vim'                                              " generate a tmux statusline matching airline
Plug 'edkolev/promptline.vim', { 'on': 'PromptlineSnapshot' }           " lazy: generate a shell prompt matching airline

" --- Snippets ---
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" --- Search ---
Plug 'rking/ag.vim', { 'on': 'Ag' }                                     " lazy: :Ag silver-searcher wrapper

" --- Misc ---
Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': 'cd app & yarn install' }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'vim-scripts/Vim-R-plugin', { 'for': 'r' }

call plug#end()

" =============================================================================
" CoC
" =============================================================================
" Extensions installed/updated automatically on startup
let g:coc_global_extensions = [
  \ 'coc-lists', 'coc-emmet', 'coc-calc', 'coc-tsserver',
  \ 'coc-snippets', 'coc-html', 'coc-css', 'coc-json',
  \ 'coc-eslint', 'coc-prettier'
  \ ]

" Refresh file from disk when focus returns (catches external changes, e.g. git checkout)
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" Allow // comments inside JSON files (e.g. tsconfig)
autocmd FileType json syntax match Comment +\/\/.\+$+
" Highlight all references to the symbol under the cursor (triggers on CursorHold, i.e. after updatetime)
autocmd CursorHold * silent call CocActionAsync('highlight')
" Run ESLint autofix on save — coc-settings approaches timed out because ESLint cold-starts in ~8s
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx silent call CocAction('runCommand', 'eslint.executeAutofix')

augroup mygroup
  autocmd!
  " Use CoC's formatter for TypeScript and JSON (respects project prettier/eslint config)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Show function signature help whenever cursor lands on a snippet placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Tab/S-Tab navigate snippet placeholders
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

" CoC keymaps
nnoremap <leader>v :call CocAction("doHover")<cr>
nmap <silent> <C-f> <Plug>(coc-cursors-position)
nmap gd :call CocAction('jumpDefinition', 'drop')<CR>          " open definition in current window (not a split)
nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>pf <Plug>(coc-format-selected)
vmap <leader>pf <Plug>(coc-format-selected)
nmap <leader>fp :CocCommand prettier.formatFile<CR>            " format entire file with prettier
nnoremap <leader>fw :CocSearch<space>

" C-j in snippet/visual mode inserts a space (placeholder expansion)
snoremap <C-j> <space>
vnoremap <C-j> <space>
" C-l in insert mode: scroll completion list down, or move cursor right
inoremap <expr> <C-l> pumvisible() ? "\<C-n>" : "\<left>"
" Tab/S-Tab navigate completion menu
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
" Enter confirms completion selection; otherwise inserts a newline and triggers coc's on_enter hook
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
  " Enable true color in terminals that support it (non-nvim)
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

" Whitelist only the airline extensions we actually use — loading all of them adds noticeable startup time
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_extensions = ['tabline', 'branch', 'coc', 'gitgutter']
let g:airline#extensions#tabline#enabled = 1
" Trim the statusline to just the parts we care about (removes mode, encoding, position clutter)
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
" Lower updatetime so CursorHold (used by CoC highlight + gitgutter) fires faster
set updatetime=300
" Stop syntax highlighting past column 200 — prevents slowdown on minified/long lines
set synmaxcol=200

" Restore cursor to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" =============================================================================
" NERDTree & Startify
" =============================================================================
let g:NERDTreeWinSize = 25
" When opening a file from startify, cd to the VCS root (git root) instead of the file's directory
let g:startify_change_to_vcs_root = 1

" Auto-close vim if NERDTree is the only remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
" Prevent :bd from accidentally closing NERDTree (closing the buffer closes the whole sidebar)
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
" Open NERDTree on startup, then immediately move focus to the main window (so startify is visible)
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
" Always open fuzzy finder from the git root, not the current buffer's directory
nnoremap <C-p> :exe 'CocList files ' . trim(system('git rev-parse --show-toplevel 2>/dev/null \|\| pwd'))<CR>
nnoremap <C-[> :exe 'CocList files ' . trim(system('git rev-parse --show-toplevel 2>/dev/null \|\| pwd'))<CR>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>                                         " reveal current file in NERDTree

" --- Buffers ---
nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>                                     " close buffer without closing the split

" --- Editing ---
nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <Up> kddpk                                                      " move line up
nnoremap <Down> ddp                                                      " move line down
nnoremap <CR> o<ESC>                                                     " insert blank line below without entering insert mode
nnoremap <C-z> a
inoremap ß <ESC>:w<CR>                                                   " Option+s saves file from insert mode
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
" j/k/l registers for temporary multi-clipboard storage
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
