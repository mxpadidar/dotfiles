vim.pack.add({ { src = "https://github.com/folke/which-key.nvim" } })

require("which-key").setup({
	delay = 300,
	icons = { mappings = false },
	spec = {
		{ "<leader>a", group = "AI" },
		{ "<leader>b", group = "Buffers" },
		{ "<leader>c", group = "Code", mode = { "n", "x" } },
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git", mode = { "n", "x" } },
		{ "<leader>m", group = "Markdown" },
		{ "<leader>r", group = "Run / restart" },
	},
})
