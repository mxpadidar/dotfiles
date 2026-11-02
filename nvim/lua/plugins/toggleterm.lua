vim.pack.add({
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("toggleterm").setup({
	direction = "horizontal",
	size = 20,
	insert_mappings = false,
	start_in_insert = true,
	auto_scroll = true,
	shade_terminals = false,
	highlights = { Normal = { guibg = "NONE" } },
})

-- Toggle terminal with leader+t
vim.keymap.set("n", "<leader>t", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
