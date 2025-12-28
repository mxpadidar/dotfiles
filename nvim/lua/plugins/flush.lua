return {
	"folke/flash.nvim",
	name = "flash",
	opts = {},
	keys = {
		{
			"gs",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
		},
	},
}
