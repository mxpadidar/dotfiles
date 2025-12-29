return {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = {
		flavour = "macchiato", -- latte, frappe, macchiato, mocha
		transparent_background = true,
		integrations = {
			telescope = true,
			treesitter = true,
			blink = true,
			dap = { enabled = true, enable_ui = true },
		},
	},
	-- config = function()
	-- 	vim.cmd.colorscheme("catppuccin")
	-- end,
}
