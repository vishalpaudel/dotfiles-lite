vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- UI
vim.opt.showcmd = true    -- Show ongoing cmd in the last line
vim.opt.laststatus = 2    -- Always show a status line
vim.opt.autowrite = true    -- Auto save on buffer change
vim.opt.cursorline = true   -- Highlight line
vim.opt.autoread = true     -- Read file on external write

-- Spaces and Tabs
vim.opt.tabstop = 4    -- Visual spaces in a tab
vim.opt.shiftwidth = 4 -- On indentation
vim.opt.shiftround = true
vim.opt.expandtab = true -- spaces are consistent

-- Keymaps
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
