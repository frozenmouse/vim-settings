set nocompatible

colorscheme mustang
syntax on

filetype off
filetype plugin indent on

set mouse=a
set number
set showmode showcmd
set nowrap
set tabstop=4 softtabstop=4 expandtab smarttab
set autoindent smartindent copyindent
set shiftwidth=4 shiftround
set backspace=indent,eol,start
set showmatch
set ignorecase smartcase
set scrolloff=4
set virtualedit=all
set hlsearch incsearch
set nolist listchars=tab:▸\ ,trail:·,extends:#,nbsp:·,eol:¬
set pastetoggle=<F2>
"set lazyredraw
set laststatus=2
set cmdheight=2
set novisualbell noerrorbells
set hidden  " hide buffers instead of closing them 
set switchbuf=useopen
set history=1000
set undolevels=1000

" persistant undo (since vim 7.3)
set undofile
set undodir=~/.vim/tmp/undo,~/tmp,/var/tmp,/tmp,.

" swap files
set swapfile
set directory=~/.vim/tmp/swap,~/tmp,/var/tmp,/tmp,.

set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class

set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
" map ; to : for reducing shift key-presses
nnoremap ; :
vnoremap ; :

" enable "very magic" mode for searching & substitution
nnoremap / /\v
vnoremap / /\v
cmap s/ s/\v

" sudo to write
cmap w!! w !sudo tee % > /dev/null

"" disable arrow keys ;)
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
 
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" clear highlighted search
nmap <space> :nohlsearch<CR>

" NERDTree toggle
nmap <F3> :NERDTreeToggle<CR>

" Split vertically and open BufExplorer
nmap <F4> :BufExplorerVerticalSplit<CR> 

" some ruby convention
au filetype ruby setlocal expandtab shiftwidth=r tabstop=2 softtabstop=2

" Restore cursor position upon reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" configure browser for haskell_doc.vim
let g:haddock_browser = "google-chrome"

let g:ragtag_global_maps = 1

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 2
let g:netrw_altv = 1

" NeoComplCache Settings
let g:neocomplcache_enable_at_startup = 1

imap <expr><Tab> pumvisible() ? "<C-n>" : neocomplcache#sources#snippets_complete#expandable() ? "<Plug>(neocomplcache_snippets_expand)" : "\<TAB>"
imap <expr><S-Tab> pumvisible() ? "<C-p>" : "<S-Tab>"
imap <expr><CR> pumvisible() && neocomplcache#sources#snippets_complete#expandable() ? "<Plug>(neocomplcache_snippets_expand)" : neocomplcache#smart_close_popup()."<CR>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'     

" Local settings
if exists("~/.vimrc.local")
	so "~/.vimrc.local"
endif
