local M = {}
local text_cache = {}

vim.api.nvim_create_autocmd("BufWipeout", {
	callback = function(args)
		text_cache[args.buf] = nil
	end,
})

local function syntax_groups(buf, row, col)
	local captures = {}
	for _, item in ipairs(vim.treesitter.get_captures_at_pos(buf, row, col)) do
		if not item.capture:match("^_") and item.capture ~= "spell" and item.capture ~= "nospell" then
			local metadata = item.metadata
			local capture_metadata = metadata[item.id] or {}
			local priority = tonumber(metadata.priority or capture_metadata.priority) or vim.hl.priorities.treesitter
			captures[#captures + 1] = {
				group = "@" .. item.capture .. "." .. item.lang,
				priority = priority,
				order = #captures + 1,
			}
		end
	end
	table.sort(captures, function(a, b)
		return a.priority == b.priority and a.order < b.order or a.priority < b.priority
	end)
	local groups = { "Folded" }
	for _, capture in ipairs(captures) do
		groups[#groups + 1] = capture.group
	end
	return groups
end

function M.text()
	local buf = vim.api.nvim_get_current_buf()
	local highlighter = vim.treesitter.highlighter.active[buf]
	local tick = vim.api.nvim_buf_get_changedtick(buf)
	local cached = text_cache[buf]
	if not cached or cached.tick ~= tick or cached.highlighter ~= highlighter then
		cached = { tick = tick, highlighter = highlighter, lines = {} }
		text_cache[buf] = cached
	end
	if cached.lines[vim.v.foldstart] then
		return cached.lines[vim.v.foldstart]
	end

	local line = vim.fn.getline(vim.v.foldstart)
	local indent = line:match("^%s*")
	local header = line:sub(#indent + 1):gsub("%s+$", "")
	local chunks = { { "+ ", "Folded" } }

	if highlighter then
		vim.treesitter.get_parser(buf):parse()
		local positions = vim.str_utf_pos(header)
		local last_groups
		for i, start in ipairs(positions) do
			local finish = (positions[i + 1] or (#header + 1)) - 1
			local groups = syntax_groups(buf, vim.v.foldstart - 1, #indent + start - 1)
			local key = table.concat(groups, "\0")
			local char = header:sub(start, finish)
			if key == last_groups then
				chunks[#chunks][1] = chunks[#chunks][1] .. char
			else
				chunks[#chunks + 1] = { char, #groups == 1 and groups[1] or groups }
				last_groups = key
			end
		end
	else
		chunks[#chunks + 1] = { header, "Folded" }
	end

	chunks[#chunks + 1] = { " ...", "Folded" }
	cached.lines[vim.v.foldstart] = chunks
	return chunks
end

local function starts_fold(line, level)
	return vim.treesitter.foldexpr(line) == ">" .. level
end

function M.toggle_nested()
	local win = vim.api.nvim_get_current_win()
	local cursor = vim.api.nvim_win_get_cursor(win)
	if vim.fn.foldlevel(cursor[1]) == 0 then
		return
	end

	local parent = cursor[1]
	while parent > 1 and not starts_fold(parent, 1) do
		parent = parent - 1
	end
	if not starts_fold(parent, 1) then
		return
	end

	local children = {}
	local last_line = vim.api.nvim_buf_line_count(0)
	for line = parent + 1, last_line do
		if vim.fn.foldlevel(line) < 1 or starts_fold(line, 1) then
			break
		end
		if starts_fold(line, 2) then
			table.insert(children, line)
		end
	end
	if #children == 0 then
		return
	end

	local parent_closed = vim.fn.foldclosed(parent) == parent
	if parent_closed then
		vim.api.nvim_win_set_cursor(win, { parent, 0 })
		vim.cmd("normal! zo")
	end

	local all_closed = true
	for _, line in ipairs(children) do
		if vim.fn.foldclosed(line) == -1 then
			all_closed = false
			break
		end
	end

	local open = parent_closed or all_closed
	for _, line in ipairs(children) do
		local closed = vim.fn.foldclosed(line)
		if (open and closed == line) or (not open and closed == -1) then
			vim.api.nvim_win_set_cursor(win, { line, 0 })
			vim.cmd(open and "normal! zo" or "normal! zc")
		end
	end

	local closed = vim.fn.foldclosed(cursor[1])
	local line = closed == -1 and cursor[1] or closed
	local text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
	vim.api.nvim_win_set_cursor(win, { line, math.min(cursor[2], #text) })
end

return M
