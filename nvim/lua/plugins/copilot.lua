vim.pack.add({
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/copilotc-nvim/copilotchat.nvim" },
})

require("copilot").setup({
	filetypes = { ["*"] = true },
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<A-y>",
			accept_word = "<A-;>",
			dismiss = "<A-e>",
			next = "<A-]>",
			prev = "<A-[>",
		},
	},
	panel = { enabled = false },
})

require("CopilotChat").setup({
	temperature = 0.1,
	window = { layout = "float", width = 0.8, height = 0.8 },
	auto_insert_mode = true,
})

vim.keymap.set({ "n", "x" }, "<leader>ac", "<Cmd>CopilotChatToggle<CR>", { desc = "Copilot chat" })
vim.keymap.set("n", "<leader>at", function()
	require("copilot.suggestion").toggle_auto_trigger()
end, { desc = "Toggle automatic AI suggestions" })
