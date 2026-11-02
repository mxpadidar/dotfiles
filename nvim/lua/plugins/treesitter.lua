vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

local treesitter = require("nvim-treesitter")
treesitter.setup()

local parsers = {
	"bash",
	"css",
	"xml",
	"html",
	"jinja",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"toml",
	"yaml",
	"astro",
	"go",
	"gomod",
	"gowork",
	"gosum",
}
treesitter.install(parsers)

-- Parser names are not always filetypes: bash/sh and tsx/typescriptreact differ.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("SyntaxHighlighting", { clear = true }),
	callback = function(event)
		local language = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
		if language and vim.list_contains(parsers, language) then
			-- A parser may still be downloading on the first run.
			pcall(vim.treesitter.start, event.buf, language)
		end
	end,
})
vim.filetype.add({ extension = { svg = "xml" } })

require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
	move = { set_jumps = true },
})

for key, capture in pairs({
	af = "@function.outer",
	["if"] = "@function.inner",
	ac = "@class.outer",
	ic = "@class.inner",
	aa = "@parameter.outer",
	ia = "@parameter.inner",
}) do
	vim.keymap.set({ "x", "o" }, key, function()
		require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
	end, { desc = "Select " .. capture:sub(2) })
end

vim.keymap.set({ "n", "x", "o" }, "]f", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function" })
vim.keymap.set({ "n", "x", "o" }, "[f", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function" })
vim.keymap.set("n", "<leader>c>", function()
	require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "Swap argument with next" })
vim.keymap.set("n", "<leader>c<", function()
	require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
end, { desc = "Swap argument with previous" })
