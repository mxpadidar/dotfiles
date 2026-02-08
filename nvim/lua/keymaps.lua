-- floating terminal
local term = require("terminal")
vim.keymap.set("n", "<leader>t", term.toggle)

-- navigation & search
vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear highlights" }) -- esc
vim.keymap.set("n", "<bs>", "<c-w>q", { desc = "Close current buffer/window" }) -- backspace

-- window management
vim.keymap.set("n", "<a-cr>", vim.cmd.vsplit) -- alt enter
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

vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true })

-- open diagnostics float
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

-- toggle copilot chat
vim.keymap.set({ "n", "v" }, "<leader><leader>", ":CopilotChat<cr>")

-- reload neovim config
vim.keymap.set("n", "<leader>so", "<cmd>source %<CR>")

-- restart lsp servers (its useful when lsp does not recognize file tree updates)
vim.keymap.set("n", "<leader>lsp", function()
	vim.cmd("LspRestart")
end, { desc = "[l]sp [r]estart" }) -- lr

-- insert literal tab character to prevent with copilot acceptance
vim.keymap.set("i", "<M-Tab>", "<Tab>", { noremap = true })

-- folding and unfolding all
vim.keymap.set("n", "fo", "zR<cr>", { noremap = true, desc = "[f]old [o]pen all" })
vim.keymap.set("n", "fc", "zM<cr>", { noremap = true, desc = "[f]old [c]lose all" })
vim.keymap.set("n", "fa", "zA<cr>", { noremap = true, desc = "[f]old [a]toggle all" })
