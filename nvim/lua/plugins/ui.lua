vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim", priority = 1000 },
	{ src = "https://github.com/olimorris/onedarkpro.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/arnamak/stay-centered.nvim", lazy = false },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})

-- Add this configuration BEFORE setting the colorscheme
require("tokyonight").setup({
	transparent = false, -- This disables the background color
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

require("ibl").setup({
	indent = { char = "│", tab_char = "│" },
	scope = { enabled = false },
})

local ibl_hooks = require("ibl.hooks")
ibl_hooks.register(ibl_hooks.type.WHITESPACE, ibl_hooks.builtin.hide_first_space_indent_level)
ibl_hooks.register(ibl_hooks.type.WHITESPACE, ibl_hooks.builtin.hide_first_tab_indent_level)

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
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = "v:lua.require'folds'.text()"
vim.opt.fillchars:append({ fold = " " })
vim.opt.foldnestmax = 2
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.keymap.set("n", "<leader>fo", "zR", { desc = "[f]old [o]pen all" })
vim.keymap.set("n", "<leader>fc", "zM", { desc = "[f]old [c]lose all" })
vim.keymap.set("n", "<leader>fO", "zo", { desc = "[f]old [o]pen current" })
vim.keymap.set("n", "<leader>fC", "zc", { desc = "[f]old [c]lose current" })
vim.keymap.set("n", "<leader>fa", "za", { desc = "[f]old toggle current" })
vim.keymap.set("n", "<leader>fA", require("folds").toggle_nested, { desc = "Toggle inner folds in current outer fold" })

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
