" Basic settings ---------------------
syntax on
set nu					" numbers
set rnu					" relative number
set ts=4	       		" spaces representing a tab
set sw=4		    	" shifiting with >> or with \n
set cb=unnamed			" To copy to system clipboard
set ai					" auto indentation
set si					" smart indentation
set hls			    	" highlight search matches
set is			    	" To show search matches as typed
set wmnu				" Wildmenu, on command pallete
set nowrap				" making long lines stay on line


" Plugins -------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'morhetz/gruvbox'
Plug 'psliwka/vim-smoothie'

Plug 'rwxrob/vim-pandoc-syntax-simple'
Plug 'vim-pandoc/vim-pandoc'
call plug#end()

augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
	au! BufNewFile,BufFilePre,BufRead *.tex set filetype=latex.pandoc
augroup END

" Advanced settings ---------------------
set nocompatible		" To use new Vim features
set ttyfast				" faster scrolling
set background=dark
set termguicolors
set rtp+=/opt/homebrew/opt/fzf
if !has('nvim')
	set term=xterm-256colors
endif

colorscheme gruvbox
