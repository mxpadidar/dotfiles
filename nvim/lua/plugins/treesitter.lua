return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	highlight = { enable = true },
	autotag = { enable = true },
	indent = { enable = false },
	config = function()
		local filetypes = {
			"python",
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"toml",
			"json5",
			"jsonc",
			"yaml",
			"html",
			"css",
			"yaml",
			"typescript",
		}
		require("nvim-treesitter").install(filetypes)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
