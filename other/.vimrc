
" Plugins
call plug#begin()
" Per file editor config
Plug 'editorconfig/editorconfig-vim'

" Search
Plug 'haya14busa/incsearch.vim'       " Better incremental search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " FZF plugin, makes Ctrl-P unnecessary
Plug 'junegunn/fzf', {'do': './install --all'}        " Fuzzy finder

" Movement
Plug 'wikitopian/hardmode'            " Disable arrow keys and similar

" Text Manipulation
Plug 'tpope/vim-sensible'             " Some better defaults
Plug 'tpope/vim-unimpaired'           " Pairs of mappings
Plug 'tpope/vim-surround'             " change surround with cs'<q> eg
Plug 'tpope/vim-commentary'           " To comment stuff out
Plug 'tpope/vim-repeat'               " Adds repeat thorugh . to other packages
Plug 'foosoft/vim-argwrap'            " convert lists of arguments into blocks of arguments
Plug 'junegunn/vim-easy-align'        " Easier alignment

" GUI enhancements
Plug 'itchyny/lightline.vim'          " Better Status Bar
Plug 'tpope/vim-vinegar'              " Browsing Files

" Git GUI
Plug 'tpope/vim-fugitive'             " Git interface
Plug 'tpope/vim-rhubarb'              " Enable GBrowse from fugitive for GitHub
Plug 'junegunn/gv.vim'                " TIG like navigation for vim

" Tmux GUI

" Autocomplete
Plug 'lervag/vimtex'                   " Latex support
Plug 'mechatroner/rainbow_csv'         " CSV color coding
Plug 'ap/vim-css-color'                " CSS colors
Plug 'frazrepo/vim-rainbow'            " Rainbow parentheses
Plug 'vim-pandoc/vim-pandoc'           " Pandoc support
Plug 'vim-pandoc/vim-pandoc-syntax'    " Pandoc syntax
Plug 'chrisbra/colorizer'              " Colorize color codes

" Language support
Plug 'rust-lang/rust.vim'              " Rust support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Colorschemes
Plug 'morhetz/gruvbox'

" Other
Plug 'wakatime/vim-wakatime'           " Wakatime time tracking
Plug 'ihsanturk/neuron.vim'            " For neuron Zettelkasten

if has('nvim-0.5')
endif

call plug#end()

" Editor Settings
" Colorscheme
colorscheme gruvbox
set background=dark

let g:python_highlight_all = 1

" Spaces & Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " Insert 4 spaces on a tab
set expandtab       " tabs are spaces, mainly because of python

" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number              " show line numbers
set relativenumber      " show relative numbering
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
filetype plugin on      " load filetype specific plugin files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set laststatus=2        " Show the status line at the bottom
set mouse+=a            " A necessary evil, mouse support
set noerrorbells visualbell t_vb=    "Disable annoying error noises
set splitbelow          " Open new vertical split bottom
set splitright          " Open new horizontal splits right
set linebreak           " Have lines wrap instead of continue off-screen
set scrolloff=12        " Keep cursor in approximately the middle of the screen
set updatetime=100      " Some plugins require fast updatetime
set ttyfast             " Improve redrawing

" Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden              " Allows having hidden buffers (not displayed in any window)

" Sensible stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start     " Make backspace behave in a more intuitive way
nmap Q <Nop>
" 'Q' in normal mode enters Ex mode. You almost never want this.
" Unbind for tmux
map <C-a> <Nop>
map <C-x> <Nop>

"Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " Ignore case in searches by default
set smartcase           " But make it case sensitive if an uppercase is entered
" turn off search highlight
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>
" Ignore files for completion
set wildignore+=*/.git/*,*/tmp/*,*.swp

" Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir


" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
" nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" This is especially useful for me since I spend my days in Python.
" Other acceptable values are marker, manual, expr, syntax, diff.
" Run :help foldmethod to find out what each of those do.

" Movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump to start and end of line using the home row keys
map H ^
map L $

" (Shift)Tab (de)indents code
vnoremap <Tab> >
vnoremap <S-Tab> <

" Capital JK move code lines/blocks up & down
" TODO improve functionality
nnoremap K :move-2<CR>==
nnoremap J :move+<CR>==
xnoremap K :move-2<CR>gv=gv
xnoremap J :move'>+<CR>gv=gv

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz


" Leader
let mapleader=" "       " leader is space

" Tmux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugin Settings
" Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --INSERT-- is unncessary because of lightline
set noshowmode

" * FZF
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8, 'relative': 'editor'}}

" vimtex
let g:tex_flavor = "latex"

" GitGutter
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"   CUSTOM SHORTCUTS  (LEADER, FN, &c)
" =============================================================================

" Modifiers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"  <Space>  --  <leader><leader> toggles between buffers
nnoremap <Leader><Leader> <c-^>

"  - |     --  Split with leader
nnoremap <Leader>- :sp<CR>
nnoremap <Leader>\| :vsp<CR>


"  w wq q   --  Quick Save
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>wq :wq<CR>
nmap <Leader>Q :q!<CR>

"  y d p P   --  Quick copy paste into system clipboard
nmap <Leader>y "+y
nmap <Leader>d "+d
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"  u    -- Undo Tree toggle show
" nnoremap <Leader>u :GundoToggle<CR>

" Miscellaneous toggles
nnoremap <Leader>oe :NERDTreeToggle<CR>
nnoremap <Leader>og :GitGutterToggle<CR>
nnoremap <Leader>om :SignatureToggle<CR>
nnoremap <Leader>op :RainbowToggle<CR>
nnoremap <Leader>ot :Vista!!<CR>
nnoremap <Leader>os :setlocal spell! spelllang=en_us<CR>

" aw    -- ArgWrap
nnoremap <Leader>aw :ArgWrap<CR>

" numbers
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>x :tabclose<CR>

" Jump to last edit position on opening file
if has("autocmd")
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.rss set filetype=xml

