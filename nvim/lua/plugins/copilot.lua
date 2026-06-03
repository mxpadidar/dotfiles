vim.pack.add({
	{ src = "https://github.com/zbirenbaum/copilot.lua", lazy = false },
	{
		src = "https://github.com/copilotc-nvim/copilotchat.nvim",
		branch = "main",
	},
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.g.copilot_filetypes = { ["*"] = true }

require("copilot").setup({
	filetypes = {
		["*"] = true,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = { accept_word = "<a-;>" },
	},
	panel = { enabled = false },
})

-- copilot uses tab to accept suggestions,
-- but we want to use tab for indentation when copilot is not visible
local copilot = require("copilot.suggestion")

vim.keymap.set("i", "<Tab>", function()
	if copilot.is_visible() then
		copilot.accept()
	else
		return "<Tab>"
	end
end, { expr = true, silent = true })

-- require("copilot_cmp").setup()

require("CopilotChat").setup({
	debug = false,
	build = "make tiktoken",
	opts = {
		model = "gpt-4.1", -- AI model to use
		temperature = 0.1, -- Lower = focused, higher = creative
		window = {
			layout = "float", -- 'vertical', 'horizontal', 'float'
			width = 0.5, -- 50% of screen width
		},
		auto_insert_mode = true, -- Enter insert mode when opening
	},
})

-- copilot chat keymaps
vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })

-- keymap to toggle copilot on and off, since it can be distracting at times
vim.keymap.set("n", "<leader>ct", function()
	if vim.g.copilot_status == nil or vim.g.copilot_status == "enable" then
		vim.cmd("Copilot disable")
		vim.g.copilot_status = "disable"
		print("🔴 Copilot OFF")
	else
		vim.cmd("Copilot enable")
		vim.g.copilot_status = "enable"
		print("🟢 Copilot ON")
	end
end, { desc = "Copilot toggle" })
