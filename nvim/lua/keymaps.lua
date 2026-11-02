local map = vim.keymap.set

-- Super manages desktop windows; Alt manages Neovim panes.
map("n", "<A-CR>", "<Cmd>vsplit<CR>", { desc = "Split pane vertically" })
map({ "i", "t" }, "<A-CR>", [[<C-\><C-n><Cmd>vsplit<CR>]], { desc = "Split pane vertically" })
map("n", "<BS>", "<C-w>q", { desc = "Close pane" })

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	map("n", "<A-" .. key .. ">", "<C-w>" .. key, { desc = "Focus " .. direction .. " pane" })
	map({ "i", "t" }, "<A-" .. key .. ">", [[<C-\><C-n><C-w>]] .. key, {
		desc = "Focus " .. direction .. " pane",
	})
end

map("n", "<A-=>", "5<C-w>>", { desc = "Widen pane" })
map("n", "<A-->", "5<C-w><", { desc = "Narrow pane" })
map("n", "<A-f>", "<C-w>|", { desc = "Maximize pane width" })
map("n", "<A-n>", "<C-w>=", { desc = "Equalize panes" })

-- Uppercase Alt bindings are Alt+Shift, leaving Alt+j/k for pane focus.
map("n", "<A-J>", ":move .+1<CR>==", { desc = "Move line down", silent = true })
map("n", "<A-K>", ":move .-2<CR>==", { desc = "Move line up", silent = true })
map("x", "<A-J>", ":move '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("x", "<A-K>", ":move '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

map("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlights" })
map({ "n", "i" }, "<C-s>", "<Cmd>update<CR>", { desc = "Save file" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("x", "p", [["_dP]], { desc = "Paste without replacing the yank register" })
map("x", "<", "<gv", { desc = "Unindent selection" })
map("x", ">", ">gv", { desc = "Indent selection" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search match" })
map("n", "N", "Nzzzv", { desc = "Previous search match" })
map("n", "<leader>cs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
	desc = "Replace word in file",
})
map("n", "<leader>cx", function()
	local result = vim.system({ "chmod", "+x", vim.api.nvim_buf_get_name(0) }):wait()
	if result.code ~= 0 then
		vim.notify(result.stderr, vim.log.levels.ERROR)
	end
end, { desc = "Make file executable" })

map("n", "<leader>re", "<Cmd>restart<CR>", { desc = "Restart Neovim" })
map("n", "<leader>cl", "<Cmd>lsp restart<CR>", { desc = "Restart language servers" })
map("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Open undo history" })
