"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                         "
"         Vim configuration file                                          "
"         ======================                                          "
"                                                                         "
"          Author: Alessandro Maggi <alessandro.maggi@gmail.com>          "
"         Version: 0.1.0                                                  "
"                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"==========================================================================
" General Settings
"==========================================================================
set t_Co=256							" terminal supports 256 colors 
set hidden								" change buffer even if unsaved
set mouse=a								" make sure mouse is used in all cases.
set mousemodel=extend					" set the model of mouse
set autoindent                          " copy indent when starting a new line
set nosmartindent						" we use autoindent
set noautowrite                         " disable autowrite
set background=light                    " I like white background
set backspace=indent,eol,start          " allow backspacing over everything
set nobackup                            " no backup files
set nocompatible                        " Vim defaults
set dictionary=/usr/share/dict/words    " keyword completion insertmode ^X^K
set nodigraph                           " disable entering of digraphs {ch1}<BS>{ch2}
set noerrorbells                        " I hate beeps!
set esckeys                             " allow usage of cursor keys
set noexpandtab                         " disable expandtab
set filetype=on                         " enable file type detection
set history=50                          " keep 50 lines of command line history
set hlsearch                            " highlight search
set incsearch							" set incremental search
set noignorecase                        " don't ignore case in search patterns
set noinsertmode                        " don't start in insert mode
set joinspaces                          " with |:join| insert 2 spaces after a '.?!'
set keywordprg=man                      " program for the "K" command
set laststatus=1                        " show status line if there are 2 windows
set magic                               " use some magic in search patterns
set nonumber                            " don't print line numbers
set report=0                            " show all changes
set ruler                               " show cursor position
set showcmd								" show current uncompleted command
set noshowmode							" show the current mode
" set scrolloff=999                     " cursor always in the middle of the window
set shiftwidth=4                        " number of spaces to use for autoindent
set shortmess=							" no abbreviation of message
set noshowmatch							" disable showmatch
set tabstop=4							" number of spaces that a <TAB> counts for
set textwidth=0							" disable textwidth
set ttyfast								" fast terminal connection
set wildchar=<TAB>						" char used for expansion on the command line
set viminfo='1000,f1,:100,/100,%,!		" save environment
set clipboard^=unnamedplus,unnamedplus	" copy&paste among instances and all other program including mouse selection
set backupdir=/tmp						" Don't want no lousy .swp files in my directoriez
set directory=/tmp
set nolist
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:␣
set wildmenu
set wildmode=list:longest,full
"set verbose=9							" useful for testing autocommands
" set visualbell						" enable visualbell and t_vb to keep Vim quiet
" set t_vb=

" ============================================================================
" Abbreviations
" ============================================================================
" correct spelling errors
iab alos also
iab aslo also
iab charcter character
iab charcters characters
iab exmaple example
iab shoudl should
iab teh the
iab tihs this
" Personal information
" N.B. <C-M> (control M )= <CR>
iab MYADDR Alessandro Maggi<C-M>Via Daria Menicanti, 13<C-M>29122 Piacenza (PC)<C-M>
iab MYCELL tel: +39 3288428789
iab MYMAIL  Alessandro Maggi <alessandro.maggi@gmail.com>
" Dates and times
iab Ddate <C-R>=strftime("%d/%m/%y")<CR>
iab Dtime <C-R>=strftime("%H:%M")<CR>
iab DDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>

" ============================================================================
" Mappings
" ============================================================================
" toggle case sensitive/insensitive
map <F2> :if &ic == 0 <Bar> :set ignorecase <Bar> :else <Bar> :set noignorecase <Bar> :endif <CR>
" toggle syntax on/off
"map <F3> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax on <Bar> endif <CR>
map <F3> :only<CR>
map <F4> :NERDTreeToggle<CR>
map <F5> :set list!<CR>

map <leader>t :TagbarToggle<CR>
" toggle mouse on/off
map <F6> :if &mouse == "a" <Bar> :set mouse= <Bar> :else <Bar> :set mouse=a <Bar> :endif <CR>
" disable the suspend for ^Z
map <C-Z> :shell<CR>
" correct a frequent mistake
"Search with F8. Hold shift for case insensitive
map <F8> :execute " grep -srnw --binary-files=without-match --exclude=tags --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow <CR>
map <S-F8> :execute " grep -isrnw --binary-files=without-match --exclude=tags --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow <CR>
map <F12> ^i#---BERTEL-<C-R>=strftime("%Y-%m-%d-AM-BEGIN")<CR><CR><ESC>
"map <F12> ^o# 0000_AM_SELTA_dsc_<C-R>=strftime("%Y_%m_%d_End")<CR><ESC>
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
" common mistake
nmap :W :w
" yank from the currend cursor position to the end of line
nnoremap Y y$
" tags with CTRLP
nnoremap <leader>. :CtrlPTag<cr>
nnoremap gr :Ack <cword><CR>
nnoremap gR :Ack '\b<cword>\b'<CR>
nnoremap <leader>h :HeaderguardAdd<CR>

" ============================================================================
" Autocommands
" ============================================================================

" remove all autocommands
"autocmd!

" Enable syntax.
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
	\ syntax on |
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" limit the width of txt files
autocmd BufReadPost,BufNewfile *.txt set textwidth=78

" limit the width of txt files
autocmd BufReadPost,BufNewfile *.md call FT_markdown()

function FT_markdown()
	set textwidth=78
endfunction


" Editing of emails and Usenet followups
" --------------------------------------

autocmd BufReadPost .article*,.letter*,mutt* call FT_mail()
function FT_mail()
   " limit the width for mail and Usenet msgs
   set textwidth=72
   " don't use accent in mail and Usenet msgs
   "imap  a`
   "imap  e`
   "imap  e'
   "imap  i`
   "imap  o`
   "imap ù u`
endfunction


" Tex files
" ---------------

autocmd FileType tex call FT_tex()
function FT_tex()
	" Mapping for beamer
	" ------------------
	nmap <leader>n  ^o\note[item]{}<ESC>
	nmap <leader>i  ^o\begin{itemize}<CR>\item item<CR>\end{itemize}<ESC>
endfunction

" C and C++ files
" ---------------

autocmd FileType c,cpp call FT_c()
function FT_c()
   " enable automatic C programming indenting
   set cindent
   " set C comments
   set comments=sr:/*,mb:*,el:*/,://
   " set formatoptions string
   set formatoptions=croql
   " set number of space that a <Tab> counts
   set tabstop=4
   " use the appropriate number of spaces to insert a <Tab>
   set expandtab
   " show the matching bracket for the last '('
   set showmatch
   " number of spaces for indent
   set shiftwidth=4
   " tags for jumping from one file to another
   set tags=./tags,tags,/home/ale/Progetti/SICAS/FW_UC_REGIME/tags
   " search files first in editing file directory and then
   set path=.,/home/ale/Progetti/SICAS/FW_UC_REGIME/**
   " C indenting style
   " default: s=>s,e0,n0,f0,{0,}0,^0,:s,=s,gs,hs,ps,ts,+s,c3,(2s,us,)20,*30
   "set cinoptions=>s,e0,n-2,f0,{0,}0,^-2,:s,=s,gs,hs,ps,t0,+s,c3,(2s,us)40,*60
   "inoremap " ""<Left>
   "inoremap ' '<Left>
   iab #i #include
   iab #d #define
   iab Ddate <C-R>=strftime("%Y_%m_%d")<CR>
   " comment selected lines
   map <F11> ^i/* 0000_AM_SELTA_dsc_<C-R>=strftime("%Y_%m_%d_Init*/")<CR><CR><ESC>
   map <F12>  ^o/* 0000_AM_SELTA_dsc_<C-R>=strftime("%Y_%m_%d_End*/")<CR><ESC>
   map <F7> oprintf("[%s:%d]Stub\n",__FILE__,__LINE__);<ESC>
   map <leader>d ^i/**<CR> @brief<CR>@fn<CR>@param[in,out]<CR>/<CR><ESC><UP>x

   let g:clang_format#code_style = "WebKit"
   let g:clang_format#command = "clang-format-3.9"

   " this make clang_complete faster
   let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang.so.1'
endfunction

" ============================================================================
" Groups
" ============================================================================

augroup gzip
   autocmd!
   autocmd BufReadPre,FileReadPre	*.gz set bin
   autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
   autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
   autocmd BufReadPost,FileReadPost	*.gz set nobin
   autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
   autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
   autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
   autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r
   autocmd FileAppendPre			*.gz !gunzip <afile>
   autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
   autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
   autocmd FileAppendPost		*.gz !gzip <afile>:r
augroup END


" greetings
au VimLeave * echo "bye!\nby Vim version"version

" remove preview windows as soon as copletetion is finished
au CompleteDone * pclose

" ============================================================================
" Plugins
" ============================================================================
"
" Plugin are manged via Vundle. So this is the only plugin that must be
" installed manually

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive' 							"Git Plugin
Plugin 'scrooloose/nerdtree'							"Browse the filesystem
Plugin 'majutsushi/tagbar'								"Display tags in right windows
Plugin 'vim-airline/vim-airline'                        "Cool status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/a.vim'								"Alternate file .c <-> .h
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter' 						"
Plugin 'mileszs/ack.vim'
Plugin 'drmikehenry/vim-headerguard'
Plugin 'rdnetto/YCM-Generator'
Plugin 'Rip-Rip/clang_complete'
Plugin 'yegappan/mru'
Plugin 'jlanzarotta/bufexplorer'
"Plugin 'bling/vim-bufferline'
"Plugin 'powerline/powerline'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"hi StatusLine       guifg=#b5b5b5 guibg=#222222 gui=none ctermbg=Black ctermfg=Red
"hi StatusLineNC       guifg=#b5b5b5 guibg=#222222 gui=none ctermbg=Black ctermfg=White
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " tab number
let g:airline#extensions#tabline#buffers_label = 'b'

let g:airline_theme='behelit'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
"let g:airline_powerline_fonts = 1
"let g:bufferline_active_highlight = 'StatusLineNC'
"let g:bufferline_inactive_highlight = 'StatusLineNC'
"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\|test$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.d$\|\.o$' }

" use ag that is faster than ack
if executable('ag')
      let g:ackprg = 'ag --column --ignore=*.d --ignore=tags'
endif
