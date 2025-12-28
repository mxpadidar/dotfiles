return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = false,
			ensure_installed = {
				"lua_ls",
				"pyright",
			},
		})

		vim.lsp.config["lua_ls"] = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
		}

		vim.lsp.config["pyright"] = {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = { ".git", "pyproject.toml", "requirements.txt" },
		}

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local map = function(keys, func, desc, mode)
					desc = "lsp: " .. desc
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end

				map("grn", vim.lsp.buf.rename, "[r]e[n]ame")
				map("gra", vim.lsp.buf.code_action, "[g]oto code [a]ction", { "n", "x" })
				-- WARN: this is not goto definition, this is goto declaration.
				map("grd", vim.lsp.buf.declaration, "[g]oto [d]eclaration")

				map("grr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
				map("gri", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")
				map("grd", require("telescope.builtin").lsp_definitions, "[g]oto [d]definition")

				-- fuzzy find all the symbols in your current document.
				--  symbols are things like variables, functions, types, etc.
				map("go", require("telescope.builtin").lsp_document_symbols, "open document symbols")

				-- fuzzy find all the symbols in your current workspace.
				--  similar to document symbols, except searches over your entire project.
				map("gw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "open workspace symbols")

				-- jump to the type of the word under your cursor.
				--  useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("grt", require("telescope.builtin").lsp_type_definitions, "[g]oto [t]ype definition")

				-- show the signature of the function under your cursor.
				map("K", vim.lsp.buf.hover, "[k]eyword hover")
			end,
		})
	end,
}
