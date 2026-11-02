local has_ui2, ui2 = pcall(require, "vim._core.ui2")
if has_ui2 then ui2.enable() end

require("options")
require("keymaps")

require("plugins.ui")
require("plugins.treesitter")
require("plugins.markdown")
require("plugins.lsp")
require("plugins.blink")
require("plugins.yazi")
require("plugins.fzf")
require("plugins.lazygit")
require("plugins.gitsigns")
require("plugins.mini")
require("plugins.toggleterm")
require("plugins.copilot")
