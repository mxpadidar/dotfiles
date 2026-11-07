vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mason").setup()
vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

vim.lsp.config("typos_lsp", {
	init_options = {
		config = vim.fn.stdpath("config") .. "/.typos.toml",
	},
})

vim.lsp.config("ty", {
	settings = { ty = { diagnosticMode = "openFilesOnly", showSyntaxErrors = false } },
})

vim.lsp.config("gopls", {
	settings = {
		gopls = { gofumpt = true, completeUnimported = true, usePlaceholders = true },
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
		},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			keyOrdering = false,
			validate = true,
			schemaStore = { enable = true },
		},
	},
})

vim.lsp.config("jsonls", {
	settings = {
		json = {
			validate = { enable = true },
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = { ".prettierrc", ".prettierrc.json" },
					url = "https://json.schemastore.org/prettierrc.json",
				},
			},
		},
	},
})

vim.lsp.config("cssls", {
	settings = { css = { lint = { unknownAtRules = "ignore" } } },
})
vim.lsp.config("jinja_lsp", { filetypes = { "htmldjango" } })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LanguageBindings", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
			buffer = event.buf,
			desc = "Rename symbol",
		})
		vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, {
			buffer = event.buf,
			desc = "Code action",
		})
	end,
})

-- Only these servers are enabled, even if old servers remain installed in Mason.
local servers = {
	"ty",
	"ruff",
	"gopls",
	"lua_ls",
	"jsonls",
	"yamlls",
	"taplo",
	"bashls",
	"astro",
	"cssls",
	"html",
	"jinja_lsp",
	"tailwindcss",
	"typos_lsp",
}
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_enable = servers,
})
