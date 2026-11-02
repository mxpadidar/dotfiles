vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })

local gitsigns = require("gitsigns")
gitsigns.setup({
	current_line_blame = false,
	on_attach = function(bufnr)
		local function map(mode, key, action, description)
			vim.keymap.set(mode, key, action, { buffer = bufnr, desc = description })
		end
		map("n", "]h", function()
			gitsigns.nav_hunk("next")
		end, "Next Git hunk")
		map("n", "[h", function()
			gitsigns.nav_hunk("prev")
		end, "Previous Git hunk")
		map("n", "<leader>gp", gitsigns.preview_hunk, "Preview Git hunk")
		map("n", "<leader>gs", gitsigns.stage_hunk, "Stage Git hunk")
		map("x", "<leader>gs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage selected lines")
		map("n", "<leader>gb", gitsigns.blame, "Show file blame")
		map("n", "<leader>gB", function()
			gitsigns.blame_line({ full = true })
		end, "Show line blame")
		map("n", "<leader>gd", gitsigns.diffthis, "Diff against index")
	end,
})
