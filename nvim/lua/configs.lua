-- global settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0
vim.g.have_nerd_font = true
vim.wo.foldmethod = "indent"
vim.wo.foldlevel = 1

vim.g.copilot_proxy = "http://localhost:2081"
vim.env.http_proxy = "http://localhost:2081"
vim.env.https_proxy = "http://localhost:2081"

-- ui
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- relative numbers
vim.opt.cursorline = true -- highlight current line
vim.o.scrolloff = 10 -- keep cursor offset from top/bottom
vim.opt.signcolumn = "yes" -- always show sign column

vim.o.signcolumn = "yes:1" -- always show sign column with width of 1 character
vim.o.winborder = "rounded" -- set default border style for floating windows

-- search
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- case-sensitive if uppercase used

-- text layout
vim.opt.wrap = true -- wrap long lines
vim.opt.breakindent = true -- keep indent on wrapped lines

-- indentation
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 2 -- spaces per tab
vim.opt.softtabstop = 2 -- spaces per <Tab> in insert mode
vim.opt.shiftwidth = 2 -- spaces per indent
vim.opt.list = true -- show invisible chars
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- splits
vim.opt.splitright = true -- vertical split to the right
vim.opt.splitbelow = true -- horizontal split below

-- persistence / clipboard
vim.opt.undofile = true -- persistent undo
vim.o.clipboard = "unnamedplus" -- system clipboard

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- diagnostic signs
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = { source = "if_many", spacing = 2 },
})
