return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	lazy = false,
	opts = {
		show_hidden = true,
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = true,
		-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
		skip_confirm_for_simple_edits = true,
		-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
		-- (:help prompt_save_on_select_new_entry)
		prompt_save_on_select_new_entry = true,
		-- Oil will automatically delete hidden buffers after this delay
		-- You can set the delay to false to disable cleanup entirely
		-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
		cleanup_delay_ms = 2000,
		-- Set to true to watch the filesystem for changes and reload oil
		watch_for_changes = false,
	},
}
