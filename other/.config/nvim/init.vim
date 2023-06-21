" What I want
" netrw, auto-save, last-location, undo
" Gruvbox
" FZF
" Git
" Language Support
" Enhancements: smooth scrolling, buffer shortcuts, text objects
" Prefer juneggun and tpope
let g:mapleader = ' '

" Sensible stuff
" netrw
let g:netrw_winsize = 30
let g:netrw_bufsettings = 'nomodifiable nomodified readonly nobuflisted nowrap number'
au FileType netrw setl bufhidden=delete
noremap <Leader>e -

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

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" Unbind for tmux
map <C-a> <Nop>
map <C-x> <Nop>

" Defaults
" Basics
set breakindent        " Wrapped part of any line also appears indented
set linebreak          " When wrapping text, break on word boundaries
set tabstop=4          " Number of spaces that a <Tab> in the file counts for
set shiftwidth=4       " Number of spaces to use for each step of (auto)indent
set incsearch
set wildmenu
set softtabstop=4
set expandtab
set hlsearch
set smartcase
set inccommand=split   " Shows the effects of a command incrementally, as you type.
set undofile           " Keep an undo file (undo changes after closing)
set number             " Display every line's number
set ttyfast             " Improve redrawing
set lazyredraw         " Don't draw while executing macros (making them faster)
set mouse=a            " Enables the use of the mouse like a normal application
set nowrap             " Disables word wrap
set scrolloff=15        " Minimal number of screen lines to keep around the cursor
set sidescroll=15       " Minimum number of characters to keep on screen
set lcs+=extends:>     " Show marker if line extends beyond screen
set matchpairs+=<:>    " Use '%' to navigate between '<' and '>'
set clipboard+=unnamedplus    " Uses clipboard by default for yank/delete/paste
set updatetime=100      " Some plugins require fast updatetime
set laststatus=2        " Show the status line at the bottom

" Folding
set nofoldenable       " Folds off by default
set foldlevelstart=10
set foldnestmax=10
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr    " Fold according to given expression (treesitter)

" Because default clang-format settings, as well as my zshrc, have 2 spaces
au FileType c,cpp,zsh,yaml set ts=2 | set sw=2 | set expandtab

" Autoformat json
au FileType json noremap <Leader>f :%!json_pp<CR>

" Text file editing
au FileType text set wrap

call plug#begin()
" Sensible stuff
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

" Text
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

" Colorscheme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'yggdroot/indentline'

" Search
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kshenoy/vim-signature'

" AST
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Language Support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'

" Enhance features
Plug 'declancm/cinnamon.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'fiatjaf/neuron.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'p00f/cphelper.nvim'

" Tmux GUI
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'

" Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

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
nmap <Leader>; :Buffers<CR>
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8, 'relative': 'editor'}}

" Git
let g:gitgutter_enabled = 1
let g:SignatureEnabledAtStartup = 1
let g:indentLine_enabled = 1

" Language Support
lua << EOF
-- Completion
local cmp = require'cmp'
cmp.setup({
snippet = {expand = function(args) require('luasnip').lsp_expand(args.body) end},
mapping = cmp.mapping.preset.insert({
["<C-Space>"] = cmp.mapping.confirm(),
["<Tab>"] = cmp.mapping.select_next_item(),
["<S-Tab>"] = cmp.mapping.select_prev_item(),
}),
sources = cmp.config.sources({{name='nvim_lsp'}, {name='luasnip'}}, {{name='buffer'}}, {{name='path'}})
})

-- Use buffer source for `/` and `?` (Doesn't work on enabling `native_menu`).
cmp.setup.cmdline({'/', '?'}, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (Doesn't work on enabling `native_menu`).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

-- Set up lspconfig.
local function on_attach(client, buf)
local function map_to(key, cmd)
vim.keymap.set('n', key, cmd, {silent=true, buffer=buf})
end

map_to('K', vim.lsp.buf.hover)
map_to('gd', vim.lsp.buf.definition)
map_to('<Leader>r', vim.lsp.buf.rename)
if client.server_capabilities.documentFormattingProvider then
	map_to('<Leader>f', vim.lsp.buf.format)
	end
	map_to('<Leader>u', vim.lsp.buf.references)
	map_to('<Leader>a', vim.lsp.buf.code_action)
	map_to('<Leader>D', vim.lsp.buf.type_definition)
	map_to('[d', vim.diagnostic.goto_prev)
	map_to(']d', vim.diagnostic.goto_next)
	end

	local lsp = require("lspconfig")
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	local function lsp_set(name, cmd, options)
	lsp[name].setup({cmd=cmd, on_attach=on_attach, settings=options, capabilities=capabilities})
	end

	lsp_set('rust_analyzer', {'rustup', 'run', 'nightly', 'rust-analyzer'}, {})
	lsp_set('clangd', {'clangd', '--clang-tidy', '--header-insertion=never'}, {})
	lsp_set('pyright', {"pyright-langserver", "--stdio"}, {})

	-- Disable displaying "HINT" diagnostics
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {severity_limit = vim.diagnostic.severity.INFO},
		signs = {severity_limit = vim.diagnostic.severity.INFO},
		underline = true,
		update_in_insert = false,
	}
	)

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "cpp", "lua", "rust", "go", "vim", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {node_incremental = "/", node_decremental = "?"},
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ["af"] = "@function.outer", ["if"] = "@function.inner",
        ["ac"] = "@class.outer", ["ic"] = "@class.inner",
        ["ab"] = "@block.outer", ["ib"] = "@block.inner",
        ["au"] = "@call.outer", ["iu"] = "@call.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = "rounded",
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}

-- Smooth scrolling
require('cinnamon').setup {
  extra_keymaps = true,
  override_keymaps = true,
  max_length = 500,
  scroll_limit = -1,
}
EOF

" Enhancements
autocmd VimLeave * execute 'silent! write !echo "%:p:h" > /tmp/pwd-info' | redraw!
let g:cph#dir = '/Users/vpaudel343/Documents/competitive-programming/practice'
let g:cph#cpp#compile_command = 'g++ -x c++ -std=gnu++17 -Wall -o cpp.out solution.cpp'
let g:cph#url_register = 'p'

" Other Sensible
" Commands to change directory to current file's and back to global
nnoremap <silent> <Leader>cd :lcd %:p:h \| pwd<CR>
nnoremap <silent> <Leader>cD :exe "lcd" getcwd(-1, -1) \| pwd<CR>

" Delete buffer without destroying window layout
command -bang Bdelete bp | bd<bang>#
