vim.pack.add({
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
})

require("yazi").setup({
	floating_window_scaling_factor = 0.8,
	-- yazi_floating_window_winblend = 10,
	open_for_directories = false,
	yazi_floating_window_border = "rounded",
	keymaps = {
		open_file_in_vertical_split = "<c-v>",
		open_file_in_horizontal_split = "<c-x>",
		grep_in_directory = "<c-s>",
		replace_in_directory = "<c-g>",
		copy_relative_path_to_selected_files = "<c-y>",
		change_working_directory = "<c-\\>",
		open_and_pick_window = "<c-o>",
	},
})

vim.keymap.set("n", "-", "<cmd>Yazi<cr>", { desc = "open yazi at the current file" })
