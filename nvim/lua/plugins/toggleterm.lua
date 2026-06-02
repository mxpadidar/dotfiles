-- Your existing config remains the same
vim.pack.add({
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("toggleterm").setup({
	direction = "horizontal",
	size = 20,
	insert_mappings = false,
	start_in_insert = true,
	auto_scroll = true,
})

-- Toggle terminal with leader+t
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
