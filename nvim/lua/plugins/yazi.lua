vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
})

require("yazi").setup({ open_for_directories = false })

vim.keymap.set("n", "-", function()
	require("yazi").yazi()
end, { desc = "open yazi at the current file" })
