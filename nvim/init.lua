local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require("configs")
require("settings")
require("keymaps")

-- load lazy.nvim plugin manager
require("lazy").setup({
	spec = { import = "./plugins" },
	install = { colorscheme = { "auto" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = true, notify = false, notify_on_warn = false },
	ui = { border = "rounded" },
})
