-- Load the plugin's Lua module without its ftplugin, which maps <CR>.
vim.pack.add({
	{ src = "https://github.com/jghauser/follow-md-links.nvim" },
}, {
	load = function(plugin)
		package.path = plugin.path .. "/lua/?.lua;" .. package.path
	end,
})

local M = {}

function M.follow_link()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local node = vim.treesitter
		.get_parser(0, "markdown_inline")
		:parse()[1]
		:root()
		:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
	while node and node:type() ~= "inline_link" do
		node = node:parent()
	end
	if node then
		for child in node:iter_children() do
			if child:type() == "link_destination" then
				local destination = vim.treesitter.get_node_text(child, 0)
				if vim.startswith(destination, "#") then
					-- Upstream currently misses same-file heading links.
					vim.cmd("normal! m'")
					local heading = destination:sub(2):gsub("-", "[- ]*"):gsub("_", "[_ ]*")
					vim.fn.search("\\c^#\\+ *" .. heading, "w")
					return
				end
			end
		end
	end
	require("follow-md-links").follow_link()
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		vim.keymap.set("n", "<leader>ml", M.follow_link, {
			buffer = args.buf,
			silent = true,
			desc = "Follow Markdown link",
		})
		vim.keymap.set("n", "<leader>mb", "<cmd>edit #<CR>", {
			buffer = args.buf,
			silent = true,
			desc = "Return to previous file",
		})
	end,
})

return M
