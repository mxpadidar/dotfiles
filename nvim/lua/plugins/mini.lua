vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
})

require("mini.surround").setup()
-- | `sa` | add surrounding or direct with 'saiw' |
-- | `sd` | delete surrounding |
-- | `sr` | replace surrounding |
