vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/arnamak/stay-centered.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})

-- Match ghostty/themes/tokyo-night-enhanced while retaining semantic highlights.
local palette = {
	bg = "#08080b",
	popup = "#16161e",
	fg = "#c0caf5",
	muted = "#787c99",
	selection = "#515c7e",
	black = "#363b54",
	red = "#f7768e",
	green = "#41a6b5",
	yellow = "#e0af68",
	string = "#9ece6a",
	blue = "#7aa2f7",
	magenta = "#bb9af7",
	cyan = "#7dcfff",
}

require("tokyonight").setup({
	style = "night",
	transparent = true,
	styles = { sidebars = "normal", floats = "normal" },
	on_colors = function(colors)
		colors.bg = palette.bg
		colors.bg_dark = palette.bg
		colors.bg_float = palette.popup
		colors.bg_popup = palette.popup
		colors.bg_sidebar = palette.bg
		colors.bg_statusline = palette.popup
		colors.bg_visual = palette.selection
		colors.fg = palette.fg
		colors.fg_dark = palette.muted
		colors.fg_float = palette.fg
		colors.fg_sidebar = palette.muted
		colors.terminal_black = palette.black
		colors.red = palette.red
		colors.green = palette.green
		colors.yellow = palette.yellow
		colors.blue = palette.blue
		colors.magenta = palette.magenta
		colors.cyan = palette.cyan
		colors.border = palette.black
		colors.comment = "#636b8c"
		colors.error = palette.red
		colors.warning = palette.yellow
		colors.info = palette.cyan
		colors.hint = palette.green
		colors.git = { add = palette.green, change = palette.blue, delete = palette.red, ignore = "#636b8c" }
		-- Match normal and bright ANSI colors, including embedded terminals.
		for name, color in pairs({
			black = palette.black,
			red = palette.red,
			green = palette.green,
			yellow = palette.yellow,
			blue = palette.blue,
			magenta = palette.magenta,
			cyan = palette.cyan,
			white = palette.muted,
		}) do
			colors.terminal[name] = color
			colors.terminal[name .. "_bright"] = color
		end
	end,
	on_highlights = function(hl)
		hl.String = { fg = palette.string }
		hl["@lsp.typemod.string.documentation"] = { link = "@string.documentation" }
		-- Let Ghostty's translucent background show through editor panes.
		hl.Normal = { fg = palette.fg, bg = "NONE" }
		hl.NormalNC = { fg = palette.fg, bg = "NONE" }
		hl.SignColumn = { fg = palette.fg, bg = "NONE" }
		hl.FoldColumn = { fg = "#636b8c", bg = "NONE" }
		hl.LineNr = { fg = "#636b8c", bg = "NONE" }
		hl.CursorLineNr = { fg = palette.yellow, bg = "NONE", bold = true }
		hl.WinSeparator = { fg = palette.black, bg = "NONE" }
		-- Keep menus and diagnostic popups solid for readability.
		hl.FloatBorder = { fg = palette.black, bg = palette.popup }
		hl.NormalFloat = { fg = palette.fg, bg = palette.popup }
		hl.Cursor = { fg = palette.bg, bg = palette.fg }
		hl.Visual = { bg = palette.selection }
	end,
})
vim.cmd.colorscheme("tokyonight-night")

require("ibl").setup({
	indent = { char = "│", tab_char = "│" },
	scope = { enabled = false },
})
local hooks = require("ibl.hooks")
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
require("stay-centered").setup({ enabled = true, allow_scroll_move = true, disable_on_mouse = true })
require("lualine").setup({
	options = { theme = "tokyonight" },
	sections = { lualine_c = { { "filename", path = 1 } } },
})

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = "v:lua.require'folds'.text()"
vim.opt.fillchars:append({ fold = " " })
vim.opt.foldnestmax = 2
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.keymap.set("n", "zN", require("folds").toggle_nested, { desc = "Toggle nested folds" })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
})
