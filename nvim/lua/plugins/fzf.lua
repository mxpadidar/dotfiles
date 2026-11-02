vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")

fzf.setup({
	defaults = {
		file_ignore_patterns = {
			".git/",
			".venv/",
			"__pycache__/",
			"node_modules/",
			".vscode/",
			".idea/",
			".cache/",
			"coverage/",
			".pytest_cache/",
			".mypy_cache/",
		},
	},
	lsp = {
		file_ignore_patterns = false,
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "[f]ind [g]rep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "[f]ind [h]elp" })

-- vim.keymap.del("n", "grr")

-- LSP mappings only when server attaches
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }

		vim.keymap.set("n", "gd", function()
			fzf.lsp_definitions({
				jump1_action = fzf.actions.file_vsplit,
				actions = {
					["enter"] = fzf.actions.file_vsplit,
				},
			})
		end, opts) -- go to definition in a vertical split
		vim.keymap.set("n", "grr", fzf.lsp_references, opts) -- go to references
		vim.keymap.set("n", "gi", fzf.lsp_implementations, opts) -- go to implementations
		vim.keymap.set("n", "gD", fzf.lsp_declarations, opts) -- go to declarations
		vim.keymap.set("n", "gy", fzf.lsp_typedefs, opts) -- go to type definitions

		-- keep default hover
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show hover documentation
	end,
})

-- diagnostics
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[c]ursor [d]iagnostics" })
vim.keymap.set("n", "<leader>dd", fzf.diagnostics_document, { desc = "[d]ocument [d]iagnostics" })
vim.keymap.set("n", "<leader>wd", fzf.diagnostics_workspace, { desc = "[w]orkspace [d]iagnostics" })

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
