set nocompatible
scriptencoding utf-8
call plug#begin('~/.vim/plugged')
"set encoding=utf-8
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, remove the outermost $TMUX check.
   "For Neovim 0.1.3 and 0.1.4
"refreshes changes automatically
" set autoread
" au CursorHold,CursorHoldI * checktime

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" be iMproved, required
filetype off " required 
" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/.vim/bundle/')

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  "remember where you come from, VIM
  " if $TERM_PROGRAM ==# 'iTerm.app'
" if (has('termguicolors')) && (has('iTerm.app'))
  " if (has('iTerm.app'))
" if has('gui_running') || has('termguicolors') && &termguicolors
  " if (has("Terminal.app"))
    " set t_Co=256
  " if $TERM_PROGRAM == "iTerm.app"
  let &t_8f="\e[38;2;%ld;%ld;%ldm"
  let &t_8b="\e[48;2;%ld;%ld;%ldm"
  set termguicolors
    " set t_Co=256
    " set t_AB=^[[48;5;%dm
    " set t_AF=^[[38;5;%dm
  " endif
" //////
  " let g:neocomplete#enable_at_startup = 1
  " " Use smartcase.
  " let g:neocomplete#enable_smart_case = 1
  " " Set minimum syntax keyword length.
  " " let g:neocomplete#sources#syntax#min_keyword_length = 3
  " let g:neocomplete#sources#syntax#min_keyword_length = 2
  " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " " Define dictionary.
  " let g:neocomplete#sources#dictionary#dictionaries = {
  "     \ 'default' : '',
  "     \ 'vimshell' : $HOME.'/.vimshell_hist',
  "     \ 'scheme' : $HOME.'/.gosh_completions'
  " \ }

  " " Define keyword.
  " if !exists('g:neocomplete#keyword_patterns')
  "     let g:neocomplete#keyword_patterns = {}
  " endif
  " let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" //////commented out

  " " Plugin key-mappings.
  " inoremap <expr><C-g>     neocomplete#undo_completion()
  " inoremap <expr><C-l>     neocomplete#complete_common_string()

  " " Recommended key-mappings.
  " " <CR>: close popup and save indent.
  " inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  " function! s:my_cr_function()
  "   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  "   " For no inserting <CR> key.
  "   "return pumvisible() ? "\<C-y>" : "\<CR>"
  " endfunction
  " " <TAB>: completion.
  " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " " Close popup by <Space>.
  " "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

  " " AutoComplPop like behavior.
  " "let g:neocomplete#enable_auto_select = 1

  " " Shell like behavior(not recommended).
  " "set completeopt+=longest
  " "let g:neocomplete#enable_auto_select = 1
  " "let g:neocomplete#disable_auto_complete = 1
  " "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
  "
  " Enable omni completion.
  autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " autocmd FileType ruby let g:SuperTabDefaultCompletionType = "context"
  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

endif

" Plugin 'vim-scripts/AutoComplPop'
Plug 'sheerun/vim-polyglot'
Plug 'epilande/vim-react-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx' "allow jsx in normal JS files added let g:jsx...
Plug 'ap/vim-css-color'

Plug 'mattn/emmet-vim'
" Plugin 'vim-colors-solarized'
Plug 'jacoborus/tender'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-rails'
" Plugin 'tomasr/molokai'
"
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
" Plugin 'vim-scripts/AutoComplPop'
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/promptline.vim'
" Plugin 'morhetz/gruvbox'
" Plugin 'tyrannicaltoucan/vim-deep-space'
"Plugin 'vim-scripts/Conque-Shell'
Plug 'vim-airline/vim-airline-themes'
"
" Plugin 'valloric/youcompleteme'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neocomplete.vim'
" Plugin 'Shougo/deoplete.nvim'
" Plug 'ervandew/supertab'
Plug 'vim-ruby/vim-ruby'
" Plugin 'flazz/vim-colorschemes'
" Plugin 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
" Plugin 'mhartington/oceanic-next'
" Plugin 'bling/vim-bufferline'
Plug 'Raimondi/delimitMate'
" Plugin 'jiangmiao/auto-pairs'

Plug 'styled-components/vim-styled-components' "styled components plugin
" Plug 'ctrlpvim/ctrlp.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-endwise'
" Plug 'terryma/vim-smooth-scroll'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'qpkorr/vim-bufkill'
" let Vundle manage Vundle, required
Plug 'tpope/vim-commentary'
Plug 'VundleVim/Vundle.vim'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'

" Plugin 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/Syntastic'
Plug 'vim-scripts/Vim-R-plugin'
" Track the engine.
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'rking/ag.vim'
", { 'do': ':UpdateRemotePlugins' }
" Plugin 'easymotion/vim-easymotion'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
" call vundle#end()      " required
call plug#end()
" filetype plugin indent on 
" To ignore plugin indent changes, instead use:
" filetype plugin on 

" func! vundle#end(...) abort
"   if (exists("g:vundle_lazy_load"))
"     unlet g:vundle_lazy_load
"   endif
"   call vundle#config#activate_bundles()
" endf
"" Brief help
" :PluginList   - lists configured plugins
" :PluginInstall  - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean    - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd    " Show (partial) command in status line.
" set showmatch    " Show matching brackets. 
"set ignorecase   " Do case insensitive matching
" set smartcase    " Do smart case matching
"set incsearch    " Incremental search
" set autowrite    " Automatically save before commands like :next and :make
set hidden   " Hide buffers when they are abandoned
set mouse=a    " Enable mouse usage (all modes)
"MY CONFIGS HERE
"FOR THE LOOKS LOL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""FOR eruby.vim"""""""""""""""""""""
"let b:surround_{char2nr('=')} = "<%= \r %>"
"let b:surround_{char2nr('-')} = "<% \r %>"
let g:surround_116 = "{/* \r\ */}"
"""""""""""""""""""""FOR eruby.vim"""""""""""""""""""""
"""""""""""""""rvm implode, then reinstall jekyll with gem install jekyll
"let mapleader = ","
"globals
" let g:snipMate = {}
" let g:snipMate.scope_aliases = {}
" let g:snipMate.scope_aliases['ruby'] = 'ruby,ruby-rails,ruby-1.9'
"
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1
" set autoindent
" set smartindent
inoremap {<CR> {<CR>}<C-o>O<TAB>

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length=1

let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 0
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" autocmd FileType ruby compiler ruby



" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
 
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-y>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" lugin 'file:///home/gmarik/path/to/plugiu'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 0
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType javascript UltiSnipsAddFiletypes html 
autocmd FileType ruby compiler ruby
set omnifunc=syntaxcomplete#Complete
set laststatus=2
"
"
"
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:closetag_filenames = "*.erb,*.html.erb,*.html,*.xhtml,*.phtml,*.js"
"let g:Powerline_symbols = 'fancy'
set number
set relativenumber
"""""""""""""""""""""""""""""""""""""""""""

" save automatically when text is changed
" set updatetime=200
" au CursorHold * silent! update

"solarized theme here
"/Users/Whisky/.vim/bundle/vim-airline-themes/autoload/airline/themes
"let g:promptline_theme = 'airline'
"let g:airline_theme='gruvbox'
"let g:airline_theme='gruvbox'
"let g:solarized_termcolors=256

" set guicolors
" set termguicolors
" let g:gruvbox_italicize_comments=1
" let g:gruvbox_italic=1
" colorscheme onehalflight
"
"
syntax on
set cursorline
colorscheme tender
" enable tender airline theme
" let g:tender_airline = 1
" set airline theme
" let g:airline_theme = 'base16_londontube'
" colorscheme melanite
" let g:airline_theme='onehalfdark'
" let g:airline_theme='onehalfdark'
" colorscheme gruvbox
" set background=dark
" let g:gruvbox_contrast_dark="hard"
" let g:gruvbox_number_column="red"
" colorscheme deep-space
" let g:airline_theme='base16_isotope'
" let g:airline_theme='deep_space'
"colorscheme solarized
"hi Normal ctermbg=none
"hi Normal ctermbg=none

" hi CursorLine cterm=bold ctermbg=8 ctermfg=NONE

" hi Comment  guifg=#80a0ff ctermfg=7


"hi CursorLine	 cterm=NONE ctermbg=8 ctermfg=white
"hi CursorLine term=bold cterm=bold guibg=Grey40
"autocmd InsertEnter * highlight CursorLine guibg=#000050 guifg=fg
"autocmd InsertLeave * highlight CursorLine guibg=#004000 guifg=fg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:indentLine_concealcursor = 'vc' "(default 'inc')
"let g:indentLine_conceallevel = 0 "(default 2)

"let g:indentLine_color_term = 15
let g:indentLine_color_term = 8
let g:indentLine_char ='│'
highlight Visual cterm=NONE ctermbg=8 ctermfg=NONE guibg=Grey40
"set listchars=tab:❯\  
"set listchars=eol:↲ ┆¦┊
"set listchars=tab:❯\ ,eol:↲ 
"set listchars=tab:⇁\ ,eol:┘


" set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
"set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
"set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4 noexpandtab 
"retab!

"set list
"set listchars=tab:\ \ ,eol:┘
" set listchars=tab:\┆\ ,eol:┘
"hi SpecialKey ctermfg=8 guifg=#649A9A
"hi SpecialKey  guifg=#649A9A
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set noet|retab!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"«»※↞↲↽⇙Γ
"┘⇁↵↸⇙
"set showbreak=↪\ 
"set listchars=tab:→\ ,eol:↲ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
"""""""""""""""""""""""""""""""""""""""""""
":so $VIMRUNTIME/syntax/hitest.vim
"autocmd CursorMoved * exe printf('match Todo  /\V\<%s\>/', escape(expand('<cword>'), '/\'))
"autocmd CursorMoved * exe printf('match Todo  /\V\<%s\>/', escape(expand('<cword>'), '/\'))
set backspace=indent,eol,start
set clipboard=unnamed

"save
inoremap ß <ESC>:w <CR>

"tab completion
" function! Tab_Or_Complete()
"   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"     return "\<C-N>"
"   else
"     return "\<Tab>"
"   endif
" endfunction
" inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
" inoremap <S-Tab> <C-P>


nnoremap <Tab> :bn!<CR>
nnoremap <S-Tab> :bp!<CR>
"nnoremap <hhhhhhhh> :BD<CR>
"nnoremap œ :BD<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
" nmap <C-w>n :NERDTreeToggle<cr>
nmap <leader>n :NERDTreeToggle<cr>

"nnoremap <silent>  ˙ :TmuxNavigateLeft<cr>
"nnoremap <silent>  ∆ :TmuxNavigateDown<cr>
"nnoremap <silent>  ˚ :TmuxNavigateUp<cr>
"nnoremap <silent>  ¬ :TmuxNavigateRight<cr>
"nnoremap <silent>  « :TmuxNavigatePrevious<cr>
"nnoremap ˙ <C-W>h
"nnoremap ∆ <C-W>j
"nnoremap ˚ <C-W>k
"nnoremap ¬ <C-W>l
"COPYING INTO REGISTERS
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
"inoremap <Up> <ESC>kddpkA
nnoremap <Up> kddpk
"inoremap <Down> <ESC>ddpA
nnoremap <Down> ddp
"nnoremap <Right> xp
"Add line without insert mode
nnoremap <CR> o<ESC>

function! P_Compile()
	let i =  expand('%:e')
	if ( i == "rb" )
		let c =  " ruby " .expand('%:p') 
		return c
  elseif ( i == 'js' )
    let c =  " node " .expand('%:p')
    return c
  elseif ( i == 'py' )
    let c =  " python " .expand('%:p')
    return c
	else
		let c = " echo lol no compiler found "
		return c
	endif
endfunc
nnoremap <leader>q :bp<cr>:bd #<cr>

let g:NERDTreeWinSize = 25
" hi Directory guifg=#82a2f0 ctermfg=red

" "ctrlp settings
" " let g:ctrlp_map='<c-p>'
" " let g:ctrlp_cmd = 'CtrlPMRU'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_max_files=0
" " let g:ctrlp_max_depth=40
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" " let g:ctrlp_cmd='CtrlP :pwd'

"fzf settings
nnoremap <C-[> :FZF<CR>
nnoremap <C-p> :GFiles<CR>

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"open a NERDTree automatically when vim starts up 
autocmd vimenter * NERDTree
"
" open a NERDTree automatically when vim starts up if no files were specified
" """""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"disable :bd in the NERDTree buffer
autocmd FileType nerdtree cnoreabbrev <buffer> bd <nop>

autocmd VimEnter * NERDTree | wincmd p
" """"""" nerdtree commented out
"

" set synmaxcol=128
" syntax sync minlines=256
" set ttyfast " u got a fast terminal
" set lazyredraw " to avoid scrolling problems

function! NumberToggle()
if(&relativenumber == 1)
	set relativenumber!
  else
	set relativenumber
  endif
endfunc

"Smooth scrool
"let me see the plugin on google chrome
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>


"nnoremap ø <CR> <c-w>h
nnoremap <leader>z :call NumberToggle()<cr>
nmap <leader>x	:w \| call VimuxRunCommand(P_Compile()) <CR>
"commented out below
" nmap <leader>w	:w \| call VimuxRunCommand(K_Compile()) <CR>
"VIMUX plugin is required for the following functions

nmap <leader>dd	:w \| call VimuxRunCommand("bundle install") <CR>
nmap <leader>rf	:w \| call VimuxRunCommand("rspec --f-f") <CR>
nmap <leader>rs	:w \| call VimuxRunCommand("rspec") <CR>
nmap <leader>Q	:w \| call VimuxRunCommand("rspec " .expand('%:p:h'). "/../spec/*" .expand('%:t:r')."*") <CR>
"nmap <leader>1q	:w \| call VimuxRunCommand(" rspec " .expand('%:p:h'). "/../spec/*" .expand('%:t:r')."* --f-f") <CR>
nmap <leader>1s	:w \| call VimuxRunCommand("rspec" .expand('%:p'). ":".line('.')) <CR>

"insert mode hjkl
"run 2 commands below in terminal for nvim. for vim it's not neccessary
"infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
"tic $TERM.ti
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>
nnoremap <C-z> a

"accidential ;w saves
imap ;w <ESC>:w<CR>

"python server localhost:8000
nmap <leader>py :call VimuxRunCommand("python -m SimpleHTTPServer") <CR>

"db/schema.rb
nmap <leader>db :call VimuxRunCommand("cat db/schema.rb") <CR>

"rake routes
nmap <leader>rr :call VimuxRunCommand("rake routes") <CR>
nmap <leader>et :call VimuxRunCommand("rake db:migrate RAILS_ENV=test") <CR>

"something related to autocompleation
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"

"Pry commands"
nmap <leader>pry :call VimuxRunCommand("pry") <CR>
nmap <leader>e :call VimuxRunCommand("exit") <CR>
nmap <leader>ee :call VimuxRunCommand("exit! ") <CR>
nmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>
vmap <leader>r :call VimuxRunCommand(getline('.') ." ") <CR>

nmap <leader>t  :w \| call VimuxRunCommand("!!") <CR>
nmap <leader>npm	:w \| call VimuxRunCommand("npm run bundle ") <CR>
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <leader>S	:w \| call VimuxRunCommand("learn && learn submit") <CR>
nmap <leader>lb	:w \| call VimuxRunCommand("learn -b") <CR>
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
" if has('nvim')
"   nmap <bs> :<c-u>TmuxNavigateLeft<cr>
" endif

" if has('nvim')
"   nmap <BS> <C-W>h
" endif

      " \'win'  : ['#I',  '#(basename #{pane_current_path})'],
let g:tmuxline_preset = {
      \'a'    : '#(whoami)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W '],
      \'y'    : ['%A', '%H:%M', '%Y-%m-%d'],
      \'z'    : '#h'}
