vim.pack.add({ { src = "https://github.com/ibhagwan/fzf-lua" } })

local fzf = require("fzf-lua")
fzf.setup({
	defaults = {
		file_ignore_patterns = {
			"%.git/",
			"%.venv/",
			"__pycache__/",
			"node_modules/",
			"%.vscode/",
			"%.idea/",
			"%.cache/",
			"coverage/",
			"%.pytest_cache/",
			"%.mypy_cache/",
		},
	},
	lsp = { file_ignore_patterns = false },
})
fzf.register_ui_select()

local map = vim.keymap.set
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Search project text" })
map("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "Find help" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Find keybindings" })
map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Find file symbols" })
map("n", "<leader>fS", fzf.lsp_live_workspace_symbols, { desc = "Find workspace symbols" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Find file diagnostics" })
map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "Find workspace diagnostics" })
map("n", "<leader>fq", fzf.quickfix, { desc = "Find quickfix entries" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show cursor diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LanguageNavigation", { clear = true }),
	callback = function(event)
		local function bind(key, action, description)
			map("n", key, action, { buffer = event.buf, desc = description })
		end
		-- Preserve the existing preference for definitions in a vertical split.
		bind("gd", function()
			fzf.lsp_definitions({
				jump1_action = fzf.actions.file_vsplit,
				actions = { ["enter"] = fzf.actions.file_vsplit },
			})
		end, "Definition in a split")
		bind("grr", fzf.lsp_references, "Find references")
		bind("gri", fzf.lsp_implementations, "Find implementations")
		bind("gD", fzf.lsp_declarations, "Find declaration")
		bind("grt", fzf.lsp_typedefs, "Find type definition")
		bind("K", vim.lsp.buf.hover, "Hover documentation")
	end,
})
