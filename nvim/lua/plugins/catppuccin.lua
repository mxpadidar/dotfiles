return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			transparent_background = true,
			integrations = {
				telescope = true,
				treesitter = true,
				blink = true,
				dap = { enabled = true, enable_ui = true },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
