vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = true } },
	fuzzy = { implementation = "prefer_rust_with_warning" },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

-- Keep AI suggestions out of the way while selecting an LSP completion.
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("CompletionSuggestions", { clear = true }),
	pattern = { "BlinkCmpMenuOpen", "BlinkCmpMenuClose" },
	callback = function(event)
		vim.b.copilot_suggestion_hidden = event.match == "BlinkCmpMenuOpen"
	end,
})
