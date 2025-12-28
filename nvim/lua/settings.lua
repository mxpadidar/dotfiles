-- ui
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- relative numbers
vim.opt.cursorline = true -- highlight current line
vim.o.scrolloff = 10 -- keep cursor offset from top/bottom
vim.opt.signcolumn = "yes" -- always show sign column

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
