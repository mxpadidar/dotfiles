-- file explorer
vim.keymap.set("n", "-", ":Oil<cr>", { desc = "open oil file explorer" }) -- dash

-- navigation & search
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear highlights" }) -- esc
vim.keymap.set("n", "<bs>", vim.cmd.bdelete, { desc = "close current buffer" }) -- backspace

-- window management
vim.keymap.set("n", "<a-cr>", vim.cmd.vsplit, { desc = "vertical split" }) -- alt enter
vim.keymap.set("n", "<a-h>", "<c-w>h", { desc = "move to left split" }) -- alt h
vim.keymap.set("n", "<a-l>", "<c-w>l", { desc = "move to right split" }) -- alt l
vim.keymap.set("n", "<a-f>", "<c-w>|", { desc = "maximize width" }) -- alt f
vim.keymap.set("n", "<a-n>", "<c-w>=", { desc = "equalize window sizes" }) -- alt n
vim.keymap.set("n", "<a-=>", "5<c-w>>", { desc = "increase width" }) -- alt =
vim.keymap.set("n", "<a-->", "5<c-w><", { desc = "decrease width" }) -- alt -

-- editing
vim.keymap.set("n", "<c-a>", "gg<s-v>G", { desc = "select all" }) -- ctrl a
vim.keymap.set("n", "<a-j>", ":m .+1<cr>==", { desc = "move line down" }) -- alt j
vim.keymap.set("n", "<a-k>", ":m .-2<cr>==", { desc = "move line up" }) -- alt k

vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

-- manual restart pyright to pick up new/changed files or project structure
vim.keymap.set("n", "<leader>rp", function()
	vim.lsp.enable("pyright", false)
	vim.lsp.enable("pyright", true)
end, { desc = "restart pyright lsp" })

-- open diagnostics float
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "open diagnostic float" })

-- write and quite all buffers
vim.keymap.set("n", "<leader>wq", vim.cmd.wqa, { desc = "[w]rite and [q]uit all" }) -- <leader>wq

-- toggle copilot chat
vim.keymap.set({ "n", "v" }, "<leader><leader>", ":CopilotChat<cr>", { desc = "open Copilot Chat" })
