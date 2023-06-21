" What I want
" netrw, auto-save, last-location, undo
" Gruvbox
" FZF
" Git
" Language Support
" Prefer juneggun and tpope
let g:mapleader = ' '

call plug#begin()
" Sensible stuff
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'

" Colorscheme
Plug 'ellisonleao/gruvbox.nvim'

" Search
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Language Support

" Enhance features

call plug#end()

" Sensible stuff
"
" netrw
let g:netrw_winsize = 30
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap number'
au FileType netrw setl bufhidden=delete
noremap <Leader>e :Lex<CR>

" auto-save
autocmd TextChanged,TextChangedI <buffer> silent write

" last-location
au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" clear-highlight
nnoremap <silent> <Esc> :noh<CR>

" undo
set undofile
set undodir=~/.vim/undodir

" Colorscheme
set termguicolors
colorscheme gruvbox
set cursorline

" Search
" For fzf plugin (\o for opening file and \g for searching through files)
set rtp+=/opt/homebrew/bin/fzf
noremap <Leader>o :Files<CR>
noremap <Leader>l :Rg<CR>
noremap <Leader>h :History:<CR>
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8, 'relative': 'editor'}}

" Git
let g:gitgutter_enabled = 0

