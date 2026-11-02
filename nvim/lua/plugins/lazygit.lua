vim.pack.add({
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

vim.keymap.set("n", "<leader>gg", "<Cmd>LazyGit<CR>", { desc = "Open LazyGit" })
