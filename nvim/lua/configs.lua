-- global settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0
vim.g.have_nerd_font = true
vim.g.copilot_proxy = "http://localhost:2081"
vim.env.http_proxy = "http://localhost:2081"
vim.env.https_proxy = "http://localhost:2081"

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
