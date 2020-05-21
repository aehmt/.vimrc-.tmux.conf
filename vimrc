set nocompatible

scriptencoding utf-8
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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " markdown preview package
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale' "Asynchronous linting/fixing for Vim
Plug 'sheerun/vim-polyglot'
Plug 'epilande/vim-react-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx' "allow jsx in normal JS files added let g:jsx...
Plug 'ap/vim-css-color'
Plug 'jacoborus/tender'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-startify' "remember state of the vim
Plug 'benmills/vimux'
Plug 'Lokaltog/vim-powerline'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'othree/html5.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/promptline.vim'
Plug 'vim-airline/vim-airline-themes'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate' "auto closing quotes, parenthesis, brackets etc
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/Syntastic'
Plug 'vim-scripts/Vim-R-plugin'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'rking/ag.vim'
call plug#end()
let g:coc_global_extensions=[ 'coc-lists', 'coc-emmet', 'coc-calc', 'coc-tsserver', 'coc-snippets', 'coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-python']
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileType json syntax match Comment +\/\/.\+$+
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
snoremap <C-j> <space>
vnoremap <C-j> <space>
nnoremap <C-j> <space>
inoremap <expr> <C-l>  pumvisible() ? "\<C-n>" : "\<left>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'
" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps
nmap <silent> <C-f> <Plug>(coc-cursors-position)
nnoremap <C-p> :CocList files<CR>
nnoremap <C-[> :CocList files<CR>
" nnoremap <C-[> :CocListResume<CR>
nnoremap <leader>fw :CocSearch<space>
nmap gd :call CocAction('jumpDefinition', 'drop')<CR>
vmap <leader>pf  <Plug>(coc-format-selected)
nmap <leader>pf  <Plug>(coc-format-selected)
nmap <leader>fp  :CocCommand prettier.formatFile<CR>
filetype off " required
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  let &t_8f="\e[38;2;%ld;%ld;%ldm"
  let &t_8b="\e[48;2;%ld;%ld;%ldm"
  set termguicolors
endif
set mouse=a
if has("syntax")
  syntax on
endif
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Use tab for trigger completion with characters ahead and navigate.
nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:surround_116 = "{/* \r\ */}"
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1
" inoremap {<CR> {<CR>}<C-o>O<TAB>
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
let g:ale_completion_enabled = 1
let g:ale_enabled = 1
let g:ale_fix_on_save = 1
" let g:ale_lint_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': [ 'prettier'],
\}
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'javascript': [ 'prettier', 'jshint']}
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"
set number
set relativenumber
syntax on
set cursorline
colorscheme tender
let g:indentLine_color_term = 8
let g:indentLine_char ='│'
highlight Visual cterm=NONE ctermbg=8 ctermfg=NONE guibg=Grey40
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set backspace=indent,eol,start
set clipboard=unnamed
inoremap ß <ESC>:w <CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>
nnoremap ; :
vnoremap a "jy
vnoremap z "ky
vnoremap x "ly
nnoremap å "jp
nnoremap Ω "kp
nnoremap ≈ "lp
inoremap ˙ <C-o>h
inoremap ∆ <C-o>gj
inoremap ˚ <C-o>gk
inoremap ¬ <C-o>l
inoremap ∑ <C-o>w
inoremap ∫ <C-o>b
inoremap … <ESC>
vnoremap … <ESC>
cnoremap … <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <Up> kddpk
nnoremap <Down> ddp
nnoremap <CR> o<ESC>
function! P_Compile()
    let i =  expand('%:e')
    if ( i == "rb" )
        return c
  elseif ( i == 'js' )
    return c
  elseif ( i == 'py' )
    return c
    else
        let c = " echo lol no compiler found "
        return c
    endif
endfunc
nnoremap <leader>q :bp<cr>:bd #<cr>
let g:NERDTreeWinSize = 25
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>
autocmd VimEnter * NERDTree | wincmd p
function! NumberToggle()
if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>z :call NumberToggle()<cr>
nmap <leader>x    :w \| call VimuxRunCommand(P_Compile()) <CR>
nmap <leader>dd   :w \| call VimuxRunCommand("bundle install") <CR>
nmap <leader>rf   :w \| call VimuxRunCommand("rspec --f-f") <CR>
nmap <leader>rs   :w \| call VimuxRunCommand("rspec") <CR>
nmap <leader>Q    :w \| call VimuxRunCommand("rspec " .expand('%:p:h'). "/../spec/*" .expand('%:t:r')."*") <CR>
nmap <leader>1s   :w \| call VimuxRunCommand("rspec" .expand('%:p'). ":".line('.')) <CR>
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>
nnoremap <C-z> a
imap ;w <ESC>:w<CR>
nmap <leader>py :call VimuxRunCommand("python -m SimpleHTTPServer") <CR>
nmap <leader>db :call VimuxRunCommand("cat db/schema.rb") <CR>
nmap <leader>rr :call VimuxRunCommand("rake routes") <CR>
nmap <leader>et :call VimuxRunCommand("rake db:migrate RAILS_ENV=test") <CR>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
nmap <leader>pry :call VimuxRunCommand("pry") <CR>
nmap <leader>e :call VimuxRunCommand("exit") <CR>
nmap <leader>ee :call VimuxRunCommand("exit! ") <CR>
nmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>
nmap <leader>t  :w \| call VimuxRunCommand("!!") <CR>
nmap <leader>npm  :w \| call VimuxRunCommand("npm run bundle ") <CR>
map  <Leader>f <Plug>(easymotion-bd-f)
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local

endif
let g:tmuxline_preset = {
      \'a'    : '#(whoami)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W '],
      \'y'    : ['%A', '%H:%M', '%Y-%m-%d'],
      \'z'    : '#h'}
