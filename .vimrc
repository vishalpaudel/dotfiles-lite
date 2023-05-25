" Basic settings ---------------------
syntax on
set nu
set rnu
set ts=4	       		" spaces representing a tab
set sw=4		    	" shifiting with >> or with \n
set cb=unnamed			" To copy to system clipboard
set ai					" auto indentation
set si					" smart indentation
set hls			    	" highlight search matches
set is			    	" To show search matches as typed

inoremap jk <ESC>		" remap jk to escape


" Advanced settings ---------------------
filetype plugin on	    " To use vim scripting
set ttyfast				" faster scrolling
set nocompatible		" To use new Vim features
set backspace=2         " To backspace on whitespaces
set background=dark
set rtp+=/opt/homebrew/opt/fzf

call plug#begin('~/.vim/plugged')
	" Vim HardTime
	Plug 'takac/vim-hardtime'
	Plug 'rwxrob/vim-pandoc-syntax-simple'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'morhetz/gruvbox'
	Plug 'psliwka/vim-smoothie'
call plug#end()

augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
let g:hardtime_default_on = 1
colorscheme gruvbox
