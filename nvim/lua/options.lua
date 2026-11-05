vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0
vim.g.have_nerd_font = true
vim.g.pyindent_open_paren = 0

local opt = vim.opt
opt.background = "dark"
opt.termguicolors = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.signcolumn = "yes:1"
opt.winborder = "rounded"
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
opt.colorcolumn = "100"
opt.pumheight = 10
opt.pumblend = 0
opt.winblend = 0
opt.showmode = false
opt.autoread = true
opt.backspace = "indent,eol,start"
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.inccommand = "split"
opt.laststatus = 3
opt.cmdheight = 0
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	virtual_text = false,
	float = { source = "if_many", border = "rounded" },
})
