-- vim.g.copilot_proxy = "http://localhost:2081"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0
vim.g.have_nerd_font = true
vim.o.background = "dark"

vim.g.pyindent_open_paren = 0
vim.opt.tabstop = 2 -- spaces per tab
vim.opt.softtabstop = 2 -- spaces per <Tab> in insert mode
vim.opt.shiftwidth = 2 -- spaces per indent
vim.opt.smartindent = true -- autoindent new lines in a smart way
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.expandtab = true -- use spaces instead of tabs

vim.opt.list = true -- show invisible chars
vim.o.number = true -- show line numbers
vim.o.relativenumber = true -- relative numbers
vim.o.cursorline = true -- highlight current line
vim.o.scrolloff = 10 -- keep cursor offset from top/bottom
vim.o.signcolumn = "yes:1" -- always show sign column with width of 1 character
vim.o.winborder = "rounded" -- set default border style for floating windows

vim.o.ignorecase = true -- case-insensitive search
vim.o.smartcase = true -- case-sensitive if uppercase used

vim.opt.showmatch = true -- briefly jump to matching bracket when inserting one
vim.opt.cmdheight = 1 -- height of the command line, one is default

vim.o.breakindent = true -- keep indent on wrapped lines

vim.o.splitright = true -- vertical split to the right
vim.o.splitbelow = true -- horizontal split below

vim.o.undofile = true -- persistent undo
vim.o.clipboard = "unnamedplus" -- system clipboard

vim.o.wrap = false -- wrap long lines
vim.opt.sidescrolloff = 10 -- Keeps 10 columns visible left/right of cursor when scrolling horizontally.
vim.opt.colorcolumn = "100" -- highlight column at 100 characters for line length guidance
vim.opt.completeopt = "menuone,noinsert,noselect" -- better completion experience
vim.opt.pumheight = 10 -- limit completion popup height to 10 items
vim.opt.pumblend = 10 -- add transparency to completion popup
vim.opt.showmode = false -- don't show -- INSERT -- etc since lualine will do that for us
vim.opt.winblend = 0 -- no transparency for floating windows by default
vim.opt.termguicolors = true

autoread = true -- automatically reload files changed outside of vim
encoding = "utf-8"
backspace = "indent,eol,start"
wildmenu = true
wildmode = "longest:full,full"

vim.o.inccommand = "split" -- show live preview of substitutions in a split
vim.o.laststatus = 3 -- global statusline

vim.o.swapfile = false -- don't create swap files
vim.o.backup = false -- don't create backup files

vim.o.undodir = vim.fn.stdpath("data") .. "/undo" -- set undo directory to a location in nvim's data path
vim.o.cmdheight = 0 -- hide command line unless needed
