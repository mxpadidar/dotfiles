vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
})

require("mini.surround").setup()

vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete()
end, { desc = "Close buffer and keep pane" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious, { desc = "Previous buffer" })
