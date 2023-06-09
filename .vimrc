" Basic settings ---------------------
syntax on
set nu                                  " numbers
set rnu                                 " relative number
set ts=4                                " spaces representing a tab
set sw=4                                " shifiting with >> or with \n
set et                                  " expand tab to spaces
set cb=unnamed                          " To copy to system clipboard
set ai                                  " auto indentation
set si                                  " smart indentation
set hls                                 " highlight search matches
set is                                  " To show search matches as typed
set nowrap                              " making long lines stay on line
set wmnu                                " Wildmenu, on command pallete
set so=15                               " Scroll margin (top and bottom)

" Plugins -------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'psliwka/vim-smoothie'

Plug 'rwxrob/vim-pandoc-syntax-simple'
Plug 'vim-pandoc/vim-pandoc'

Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
call plug#end()

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.tex set filetype=latex.pandoc
augroup END
" copy template on making cpp file
autocmd BufNewFile *.cpp -r ${CP_HOME}/misc/temp.cpp
" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" increase fold level
autocmd FileType Results setlocal foldlevel=5

" Appearance settings ---------------------
colorscheme gruvbox
set background=dark
