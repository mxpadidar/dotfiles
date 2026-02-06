local M = {}

local term = {
	bufid = -1,
	winid = -1,
}

local function get_config()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	return {
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) * 0.5),
		row = math.floor((vim.o.lines - height) * 0.5),
		relative = "editor",
		border = "rounded",
		style = "minimal",
	}
end

local function close()
	if term.winid ~= -1 and vim.api.nvim_win_is_valid(term.winid) then
		vim.api.nvim_win_close(term.winid, false)
		term.winid = -1
	end
end

local function create_buffer()
	local bufid = vim.api.nvim_create_buf(false, true)
	term.winid = vim.api.nvim_open_win(bufid, true, get_config())
	vim.cmd.terminal()
	term.bufid = vim.api.nvim_get_current_buf()

	-- Set buffer options
	vim.bo[term.bufid].buflisted = false
	vim.bo[term.bufid].bufhidden = "hide"

	-- Assign keymaps to the terminal buffer
	local opts = { buffer = term.bufid, noremap = true, silent = true }
	vim.keymap.set("t", "<esc>", "<c-\\><c-n>", opts)
	vim.keymap.set("n", "<esc>", close, opts)
	vim.keymap.set("n", "q", close, opts)
end

local function open()
	-- Create buffer and window if not exists
	if term.bufid == -1 or not vim.api.nvim_buf_is_valid(term.bufid) then
		create_buffer()
	else
		-- Buffer exists, just open window
		term.winid = vim.api.nvim_open_win(term.bufid, true, get_config())
	end

	vim.cmd("startinsert")
end

function M.toggle()
	if term.winid ~= -1 and vim.api.nvim_win_is_valid(term.winid) then
		close()
	else
		open()
	end
end

-- kill terminal job on quit to prevent e948 error
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		if term.bufid ~= -1 and vim.api.nvim_buf_is_valid(term.bufid) then
			local job_id = vim.bo[term.bufid].channel
			if job_id and job_id > 0 then
				vim.fn.jobstop(job_id)
			end
		end
	end,
})

return M
