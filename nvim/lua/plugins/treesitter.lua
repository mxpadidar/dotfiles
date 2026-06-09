vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},
})

require("nvim-treesitter").setup({
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
})

local ft_list = {
	"bash",
	"css",
	"html",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"toml",
	"yaml",
	"astro",
	"go",
}

require("nvim-treesitter").install(ft_list)

vim.api.nvim_create_autocmd("FileType", {
	pattern = ft_list,
	callback = function()
		vim.treesitter.start()
	end,
})
