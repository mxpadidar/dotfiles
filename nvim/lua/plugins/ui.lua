vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim", priority = 1000 },
	{ src = "https://github.com/olimorris/onedarkpro.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/arnamak/stay-centered.nvim", lazy = false },
})

-- Add this configuration BEFORE setting the colorscheme
require("tokyonight").setup({
	transparent = true, -- This disables the background color
	-- style = "night", -- Keep your preferred style
	styles = {
		sidebars = "dark", -- Change from "transparent" to "dark"
		floats = "dark", -- Change from "transparent" to "dark"
	},
	on_highlights = function(highlights, colors)
		-- Customize border colors here
		highlights.WinSeparator = {
			fg = colors.comment, -- Uses Tokyo Night's comment color
		}
	end,
})

-- Then set the colorscheme
vim.cmd([[colorscheme tokyonight-night]])

require("stay-centered").setup({
	skip_filetypes = {},
	enabled = true,
	allow_scroll_move = true,
	disable_on_mouse = true,
})

require("lualine").setup({
	options = { theme = "tokyonight" },
	sections = {
		lualine_c = {
			{ "filename", path = 1, color = "white" },
		},
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.wo.foldlevel = 10

vim.keymap.set("n", "<leader>fo", "zR<cr>", { desc = "[f]old [o]pen all" })
vim.keymap.set("n", "<leader>fc", "zM<cr>", { desc = "[f]old [c]lose all" })
vim.keymap.set("n", "<leader>fa", "za<cr>", { desc = "[f]old [a]toggle all" })

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})
