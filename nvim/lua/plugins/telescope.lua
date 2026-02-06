return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		-- enable telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "__pycache__/" },
			},
		})

		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")

		vim.keymap.set("n", "<a-o>", function()
			builtin.find_files(themes.get_dropdown({
				previewer = false,
			}))
		end, { desc = "[f]ind [f]iles (dropdown)" })

		vim.keymap.set("n", "<a-b>", function()
			builtin.buffers(themes.get_dropdown({
				previewer = false,
			}))
		end, { desc = "[f]ind [b]buffers" })

		vim.keymap.set("n", "<a-g>", builtin.live_grep, { desc = "[f]ind by [g]rep" })

		vim.keymap.set("n", "fib", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({
				previewer = false,
			}))
		end, { desc = "[f]ind [i]n current [b]buffer" })

		vim.keymap.set("n", "fh", builtin.help_tags, { desc = "[f]ind [h]elp" })
		vim.keymap.set("n", "fk", builtin.keymaps, { desc = "[f]ind [k]eymaps" })
		vim.keymap.set("n", "fs", builtin.builtin, { desc = "[f]ind [s]elect telescope" })
		vim.keymap.set("n", "fw", builtin.grep_string, { desc = "[f]ind current [w]ord" })
		vim.keymap.set("n", "fr", builtin.resume, { desc = "[f]ind [r]esume" })
		vim.keymap.set("n", "fd", builtin.diagnostics, { desc = "[f]ind [d]iagnostics" })

		-- shortcut for searching your neovim configuration files
		vim.keymap.set("n", "fnc", function()
			builtin.find_files(themes.get_dropdown({
				previewer = false,
				cwd = vim.fn.stdpath("config"),
			}))
		end, { desc = "[s]earch [n]eovim [c]onfig" })
	end,
}
