return {
	"stevearc/conform.nvim",
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"ruff",
				-- "stylua", -- stylua needs rust, its better to install it manually
				"rustfmt",
				"codespell",
				"prettier",
			},
		})
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				md = { "prettier" },
				markdown = { "prettier" },
				jsonc = { "prettier" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			format_after_save = {
				lsp_format = "fallback",
			},
			log_level = vim.log.levels.ERROR,
			notify_on_error = true,
			notify_no_formatters = true,
		})
	end,
}
