" number, cursor, etc.
set number                  " add line numbers
set cursorline              " highlight current cursorline
set ignorecase              " case insensitive
syntax on                   " syntax highlighting

" colors and theme
set background=dark
colorscheme slate

" search
set hlsearch                " highlight search 
set incsearch               " incremental search
set showmatch               " show matching 

" mouse
set mouse=v                 " middle-click paste with 
set mouse=a                 " enable mouse click

" spaces and tabs
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
filetype plugin indent on   "allow auto-indenting depending on file type

" general stuff
set wildmode=longest,list   " get bash-like tab completions
set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " Speed up scrolling in Vim
set modifiable              " be able to modify nerd tree

" spelling
set spell                 " enable spell check (may need to download language package)

" might need some day
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/nvim " Directory to store backup files.

" auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" enable plugins
filetype plugin on

" plugin section
call plug#begin()
    " themes 
    Plug 'morhetz/gruvbox'
    Plug 'tomasr/molokai'

    " code completion & snippets 
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    " convenient stuff
    Plug 'ryanoasis/vim-devicons'    " NERDFonts are required
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" ###############
" NERDTree config
" ###############
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
" show file lines
let g:NERDTreeFileLines = 1

" custom key bindings
nmap <C-f> :NERDTreeToggle<CR>

" ####################
" NERDCommenter config
" ####################
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" custom key bindings
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" #######################
" CoC - completion engine
" #######################
" the plugins to use
let g:coc_global_extensions = ['coc-python', 'coc-cmake', 'coc-docker', 'coc-git', 'coc-java', 'coc-markdownlint', 'coc-rust-analyzer', 'coc-sh', 'coc-snippets']

" use tab to shift throw the list
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
