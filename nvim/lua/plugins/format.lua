vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "prettier", "shfmt", "mbake", "djlint", "xmlformatter" },
	auto_update = false,
})

-- Organize Go imports synchronously before Conform formats the saved buffer.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("GoImports", { clear = true }),
	pattern = "*.go",
	callback = function(event)
		local client = vim.lsp.get_clients({ bufnr = event.buf, name = "gopls" })[1]
		if not client then
			return
		end
		local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
		params.context = { only = { "source.organizeImports" }, diagnostics = {} }
		local response, err = client:request_sync("textDocument/codeAction", params, 1000, event.buf)
		if not response or response.err then
			vim.notify("Go imports: " .. vim.inspect(err or (response and response.err)), vim.log.levels.WARN)
			return
		end
		for _, action in ipairs(response.result or {}) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
			end
			if action.command then
				local command = type(action.command) == "table" and action.command or action
				client:request_sync("workspace/executeCommand", command, 1000, event.buf)
			end
		end
	end,
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
		go = { lsp_format = "prefer" },
		lua = { "stylua" },
		sh = { "shfmt" },
		make = { "mbake" },
		htmldjango = { "djlint" },
		xml = { "xmlformatter" },
		html = { "prettier" },
		css = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		astro = { "prettier" },
		toml = { "taplo" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 1500 },
	formatters = {
		djlint = { command = "djlint", args = { "--reformat", "--indent", "2", "-" }, stdin = true },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set({ "n", "x" }, "<leader>cf", function()
	conform.format({ async = true })
end, { desc = "Format buffer or selection" })
