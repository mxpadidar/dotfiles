vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim", build = "cargo build --release --locked" },
})

require("mason").setup({})

require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		"lua_ls",
		"ruff",
		"jsonls",
		"yamlls",
		"pyright",
		"astro",
		"cssls",
		"html",
		"bashls",
		"gopls",
		"typos_lsp",
		"taplo",
		"jinja_lsp",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"prettierd",
		"mdformat",
		"shfmt",
		"prettierd",
		"mbake",
		"djlint",
		"xmlformatter",
		"tailwindcss-language-server",
	},
	auto_update = true,
	run_on_start = true,
})

-- Register before Conform's save hook so imports are ready for formatting.
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function(args)
		local client = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })[1]
		if not client or not client:supports_method("textDocument/codeAction", args.buf) then
			return
		end

		local last_line = vim.api.nvim_buf_line_count(args.buf) - 1
		local last_text = vim.api.nvim_buf_get_lines(args.buf, last_line, last_line + 1, true)[1]
		local params = {
			textDocument = vim.lsp.util.make_text_document_params(args.buf),
			range = {
				start = { line = 0, character = 0 },
				["end"] = { line = last_line, character = #last_text },
			},
			context = { only = { "source.organizeImports" }, diagnostics = {} },
		}
		local response, err = client:request_sync("textDocument/codeAction", params, 1000, args.buf)
		if not response or response.err then
			vim.notify("gopls organize imports failed: " .. vim.inspect(err or response.err), vim.log.levels.WARN)
			return
		end

		for _, action in ipairs(response.result or {}) do
			if action.kind == "source.organizeImports" then
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
				end
				if action.command then
					local command = type(action.command) == "table" and action.command or action
					client:request_sync("workspace/executeCommand", command, 1000, args.buf)
				end
				break
			end
		end
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		go = { lsp_format = "prefer" },
		make = { "mbake" },
		htmldjango = { "djlint" },
		html = { "prettierd", "prettier", stop_after_first = true },
		xml = { "xmlformatter" },
		css = { "prettierd", "prettier", stop_after_first = true },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		mjs = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettierd" },
		json = { "prettier" },
		jsonc = { "prettier" },
		toml = { "taplo" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		astro = { "prettier" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { timeout_ms = 1000 },
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
	formatters = {
		djlint = {
			command = "djlint",
			args = { "--reformat", "--indent", "2", "-" },
			stdin = true,
		},
	},
})

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
}

vim.lsp.config("yamlls", {
	filetypes = { "yaml", "yml" },
	settings = {
		yaml = {
			keyOrdering = false,
			format = { enable = true },
			validate = true,
			schemaStore = { enable = false, url = "" },
		},
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { "utf-8" }

vim.lsp.config("ruff", { capabilities = capabilities })
vim.lsp.config("pyright", {
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true,
			disableTaggedHints = true,
		},
		python = {
			analysis = {
				ignore = { "*" },
			},
		},
	},
})

vim.lsp.config("cssls", {
	capabilities = capabilities,
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

vim.lsp.enable("astro")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("yamlls")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")

vim.lsp.config("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			-- staticcheck = true,
			gofumpt = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.config("jinja_lsp", {
	filetypes = { "htmldjango" },
})

vim.lsp.enable("jinja_lsp")

vim.lsp.config("html", {
	filetypes = { "html", "xml" }, -- defaults may already include xml, but explicit is safe
})

vim.lsp.enable("taplo")
vim.lsp.enable("tailwindcss-language-server")
