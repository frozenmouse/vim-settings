" NeoBundle Scripts {{{
if has('vim_starting')
  set nocompatible " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tmatilai/vim-monit'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
" vim-script
NeoBundle 'dogmatic.vim'
NeoBundle 'FuzzyFinder'
NeoBundle 'L9'
NeoBundle 'localvimrc'
NeoBundle 'nginx.vim'
NeoBundle 'OmniCppComplete'
NeoBundle 'ragtag.vim'
NeoBundle 'taglist.vim'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" }}}

colorscheme mustang
syntax on

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

" persistent undo (since vim 7.3)
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
au filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Restore cursor position upon reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc

" configure browser for haskell_doc.vim
let g:haddock_browser = "xdg-open"

let g:ragtag_global_maps = 1

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 2
let g:netrw_altv = 1

" neocomplete Settings
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1

function! s:cr_map()
"  return pumvisible() ? neocomplete#close_popup() :
"       \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
"       \ "\<CR>"
  return neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
       \ pumvisible() ? neocomplete#close_popup() : 
       \ "\<CR>" 
endfunction

inoremap <expr><C-\>   neocomplete#start_manual_complete()
imap     <expr><CR>    <SID>cr_map()
smap     <expr><CR>    <SID>cr_map()
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><BS>    neocomplete#smart_close_popup() . "\<BS>"
inoremap <expr><C-y>   pumvisible() ? neocomplete#close_popup() : "\<C-y>"
inoremap <expr><C-e>   pumvisible() ? neocomplete#cancel_popup() : "\<C-e>"

" Enable omni completion
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'     

let g:rubycomplete_rails = 1

" vim-monit: auto detect ft for per-user monitrc
autocmd BufNewFile,BufRead .monitrc set filetype=monitrc

" Local settings
if exists("~/.vimrc.local")
  so "~/.vimrc.local"
endif

" vim:et:ts=2:sw=2
