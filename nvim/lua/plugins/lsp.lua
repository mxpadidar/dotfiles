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
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"yamlfix",
		"prettier",
		"mdformat",
		"shfmt",
		"mbake",
		"prettierd",
		"goimports",
		"golines",
	},
	auto_update = true,
	run_on_start = true,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		go = { "golines", "goimports", "gofmt" },
		make = { "mbake" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		astro = { "prettierd" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
	format_after_save = { lsp_format = "fallback" },
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
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
		},
		python = {
			analysis = {
				ignore = { "*" },
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

vim.lsp.config("gopls", {
	capabilities = capabilities,
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})

-- go install github.com/owenrumney/make-ls/cmd/make-ls@latest
-- ensure make-ls is in your PATH
vim.lsp.config("make_ls", {
	cmd = { "make-ls" },
	filetypes = { "make" },
	root_markers = { "Makefile", "makefile", "GNUmakefile", ".git" },
})

vim.lsp.enable("make_ls")
