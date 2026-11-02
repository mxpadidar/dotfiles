vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

local gitsigns = require("gitsigns")

gitsigns.setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 300,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	on_attach = function(bufnr)
		vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", {
			buffer = bufnr,
			desc = "[g]it [b]lame: toggle file authors",
		})
		vim.keymap.set("n", "<leader>gB", function()
			gitsigns.blame_line({ full = true })
		end, {
			buffer = bufnr,
			desc = "[g]it [B]lame: current line commit",
		})
	end,
})
