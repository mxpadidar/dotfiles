return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "cargo build --release",

	opts = {
		keymap = { preset = "default" },
		appearance = { nerd_font_variant = "mono" },
		completion = { documentation = { auto_show = false } },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = {
			prebuilt_binaries = { force_version = "1.6.0" },
			implementation = "prefer_rust", -- "lua" if build fails
		},
	},

	opts_extend = { "sources.default" },
}
