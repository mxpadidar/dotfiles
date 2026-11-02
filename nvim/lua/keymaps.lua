-- windows management
vim.keymap.set("n", "<a-cr>", vim.cmd.vsplit) -- alt enter
-- Move between splits in both normal and terminal modes
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "move to left split" })
vim.keymap.set("t", "<c-h>", [[<C-\><C-n><C-w>h]], { desc = "move to left split" })
-- windows management
vim.keymap.set("n", "<a-cr>", vim.cmd.vsplit) -- alt enter
-- Move between splits in both normal and terminal modes
vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "move to left split" })
vim.keymap.set("t", "<c-h>", [[<C-\><C-n><C-w>h]], { desc = "move to left split" })

vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "move to right split" })
vim.keymap.set("t", "<c-l>", [[<C-\><C-n><C-w>l]], { desc = "move to right split" })

vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "move to down split" })
vim.keymap.set("t", "<c-j>", [[<C-\><C-n><C-w>j]], { desc = "move to down split" })

vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "move to up split" })
vim.keymap.set("t", "<c-k>", [[<C-\><C-n><C-w>k]], { desc = "move to up split" })
vim.keymap.set("n", "<a-=>", "5<c-w>>", { desc = "increase width" }) -- alt =
vim.keymap.set("n", "<a-->", "5<c-w><", { desc = "decrease width" }) -- alt -

vim.keymap.set("n", "<bs>", "<c-w>q", { desc = "close current buffer/window" }) -- backspace

-- helpers
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear highlights" }) -- esc
vim.keymap.set("n", "<a-f>", "<c-w>|", { desc = "maximize width" }) -- alt f
vim.keymap.set("n", "<a-n>", "<c-w>=", { desc = "equalize window sizes" }) -- alt n
vim.keymap.set("n", "<c-a>", "gg<s-v>G", { desc = "select all" }) -- ctrl a
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true })

-- restart lsp servers (its useful when lsp does not recognize file tree updates)
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("lsp restart")
end, { desc = "[l]sp [r]estart" }) -- lr

-- new keymaps
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set("v", "<a-j>", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "<a-k>", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "<a-j>", ":m .+1<cr>==", { desc = "move line down" }) -- alt j
vim.keymap.set("n", "<a-k>", ":m .-2<cr>==", { desc = "move line up" }) -- alt k

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "move to right split" })
vim.keymap.set("t", "<c-l>", [[<C-\><C-n><C-w>l]], { desc = "move to right split" })

vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "move to down split" })
vim.keymap.set("t", "<c-j>", [[<C-\><C-n><C-w>j]], { desc = "move to down split" })

vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "move to up split" })
vim.keymap.set("t", "<c-k>", [[<C-\><C-n><C-w>k]], { desc = "move to up split" })
vim.keymap.set("n", "<a-=>", "5<c-w>>", { desc = "increase width" }) -- alt =
vim.keymap.set("n", "<a-->", "5<c-w><", { desc = "decrease width" }) -- alt -

vim.keymap.set("n", "<bs>", "<c-w>q", { desc = "close current buffer/window" }) -- backspace

-- helpers
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear highlights" }) -- esc
vim.keymap.set("n", "<a-f>", "<c-w>|", { desc = "maximize width" }) -- alt f
vim.keymap.set("n", "<a-n>", "<c-w>=", { desc = "equalize window sizes" }) -- alt n
vim.keymap.set("n", "<c-a>", "gg<s-v>G", { desc = "select all" }) -- ctrl a
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true })

-- restart lsp servers (its useful when lsp does not recognize file tree updates)
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("lsp restart")
end, { desc = "[l]sp [r]estart" }) -- lr

-- new keymaps
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set("v", "<a-j>", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "<a-k>", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "<a-j>", ":m .+1<cr>==", { desc = "move line down" }) -- alt j
vim.keymap.set("n", "<a-k>", ":m .-2<cr>==", { desc = "move line up" }) -- alt k

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
