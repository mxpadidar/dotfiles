return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,

	opts = {
		ensure_installed = {
			"python",
			"lua",
			"bash",
			"markdown",
			"toml",
			"json",
			"yaml",
			"bash",
			"c",
			"jsonc",
			"diff",
			"html",
			"css",
			"vim",
			"typescript",
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
	},
}
