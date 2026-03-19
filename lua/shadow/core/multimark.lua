-- multimark.lua
-- Place in ~/.config/nvim/lua/multimark.lua
-- Then add `require("multimark")` to your init.lua

local M = {}

-- List of marks: { file, line, col, buf }
local marks = {}
-- Current index when cycling through marks
local current_idx = nil

-- Return a display-friendly label for a mark
local function mark_label(m, idx)
	local short = vim.fn.fnamemodify(m.file, ":~:.")
	return string.format("[%d] %s:%d:%d", idx, short, m.line, m.col)
end

-- Prune marks whose buffers have been wiped / files closed
local function prune_closed()
	local alive = {}
	for _, m in ipairs(marks) do
		-- buflisted returns 1 if the buffer still exists and is listed
		if vim.fn.buflisted(m.buf) == 1 then
			table.insert(alive, m)
		end
	end
	marks = alive
end

-- Mark the current file + cursor position
function M.mark_file()
	local buf  = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)
	if file == "" then
		vim.notify("multimark: buffer has no file name", vim.log.levels.WARN)
		return
	end

	local pos  = vim.api.nvim_win_get_cursor(0)
	local line = pos[1]
	local col  = pos[2] + 1 -- 1-based for display

	-- Check for an existing mark on the same file+line+col and remove it (toggle)
	for i, m in ipairs(marks) do
		if m.file == file and m.line == line and m.col == col then
			table.remove(marks, i)
			vim.notify("multimark: removed " .. mark_label(m, i), vim.log.levels.INFO)
			return
		end
	end

	local mark = { file = file, line = line, col = col, buf = buf }
	table.insert(marks, mark)
	vim.notify("multimark: marked " .. mark_label(mark, #marks), vim.log.levels.INFO)
end

-- Jump to the next mark (cycles through the list)
function M.jump_mark()
	prune_closed()

	if #marks == 0 then
		vim.notify("multimark: no marks", vim.log.levels.WARN)
		return
	end

	-- Advance index
	if current_idx == nil or current_idx >= #marks then
		current_idx = 1
	else
		current_idx = current_idx + 1
	end

	local m = marks[current_idx]

	-- Open the file if not in a listed buffer
	if vim.fn.buflisted(m.buf) ~= 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(m.file))
		m.buf = vim.api.nvim_get_current_buf()
	else
		vim.api.nvim_set_current_buf(m.buf)
	end

	-- Restore cursor (nvim_win_set_cursor is 0-based col)
	local ok = pcall(vim.api.nvim_win_set_cursor, 0, { m.line, m.col - 1 })
	if not ok then
		vim.notify("multimark: could not restore cursor position", vim.log.levels.WARN)
	end

	vim.notify(
		string.format("multimark: %d/%d  %s", current_idx, #marks, mark_label(m, current_idx)),
		vim.log.levels.INFO
	)
end

-- List all current marks (for debugging / inspection)
function M.list_marks()
	prune_closed()
	if #marks == 0 then
		print("multimark: no marks")
		return
	end
	for i, m in ipairs(marks) do
		local indicator = (i == current_idx) and " <--" or ""
		print(mark_label(m, i) .. indicator)
	end
end

-- Clear all marks
function M.clear_marks()
	marks = {}
	current_idx = nil
	vim.notify("multimark: all marks cleared", vim.log.levels.INFO)
end

-- ---------------------------------------------------------------------------
-- Delete marks UI
--
-- Opens a floating window listing all marks.
-- <Tab>  — toggle selection on the current line (moves cursor down)
-- j/k    — move up/down
-- d      — confirm deletion of selected marks (default: Yes), then close
-- q      — quit without deleting
-- ---------------------------------------------------------------------------
function M.delete_marks_ui()
	prune_closed()

	if #marks == 0 then
		vim.notify("multimark: no marks to manage", vim.log.levels.WARN)
		return
	end

	local snapshot = vim.deepcopy(marks)
	local selected = {} -- set of snapshot indices currently selected

	local function build_lines()
		local lines = {}
		for i, m in ipairs(snapshot) do
			local prefix = selected[i] and "» " or "  "
			lines[i] = prefix .. mark_label(m, i)
		end
		return lines
	end

	-- Create non-editable scratch buffer
	local buf             = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buftype   = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile  = false

	local function refresh()
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, build_lines())
		vim.bo[buf].modifiable = false
	end
	refresh()

	-- Floating window
	local width            = math.min(90, vim.o.columns - 4)
	local height           = math.min(#snapshot + 2, vim.o.lines - 6)
	local row              = math.floor((vim.o.lines - height) / 2)
	local col              = math.floor((vim.o.columns - width) / 2)

	local win              = vim.api.nvim_open_win(buf, true, {
		relative  = "editor",
		width     = width,
		height    = height,
		row       = row,
		col       = col,
		style     = "minimal",
		border    = "solid",
		title     = " multimark: delete  (<Tab> select · d delete · q quit) ",
		title_pos = "center",
	})
	vim.wo[win].cursorline = true
	vim.wo[win].wrap       = false

	-- Syntax highlights
	vim.cmd([[
    syntax match MultiMarkSelected /^» .*/
    syntax match MultiMarkIndex    /\[\d\+\]/
    syntax match MultiMarkFile     /\]\s\+\zs[^:]\+/
    syntax match MultiMarkPos      /:\d\+:\d\+/
    highlight default MultiMarkSelected guifg=Yellow gui=bold
    highlight default link MultiMarkIndex  Number
    highlight default link MultiMarkFile   String
    highlight default link MultiMarkPos    Constant
  ]])

	local opts = { buffer = buf, nowait = true, silent = true }

	-- <Tab>: toggle selection, advance cursor
	vim.keymap.set("n", "<Tab>", function()
		local lnum = vim.api.nvim_win_get_cursor(win)[1]
		selected[lnum] = not selected[lnum] or nil
		refresh()
		vim.api.nvim_win_set_cursor(win, { math.min(lnum + 1, #snapshot), 0 })
	end, opts)

	-- d: confirm and delete
	vim.keymap.set("n", "d", function()
		local count = vim.tbl_count(selected)
		if count == 0 then
			vim.notify("multimark: nothing selected", vim.log.levels.WARN)
			return
		end
		local label = count == 1 and "1 mark" or (count .. " marks")
		local answer = vim.fn.confirm("Delete " .. label .. "?", "&Yes\n&No", 1)
		if answer ~= 1 then return end

		local kept = {}
		for i, m in ipairs(snapshot) do
			if not selected[i] then table.insert(kept, m) end
		end
		marks = kept
		if current_idx and current_idx > #marks then
			current_idx = #marks > 0 and #marks or nil
		end
		vim.notify(
			string.format("multimark: %d mark(s) removed, %d remaining", count, #marks),
			vim.log.levels.INFO
		)
		vim.api.nvim_win_close(win, true)
	end, opts)

	-- q: quit without changes
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, opts)
end

-- Keymaps
vim.keymap.set("n", "mf", M.mark_file, { desc = "MultiMark: mark current position" })
vim.keymap.set("n", "mm", M.jump_mark, { desc = "MultiMark: jump to next mark" })
vim.keymap.set("n", "ml", M.list_marks, { desc = "MultiMark: list all marks" })
vim.keymap.set("n", "mc", M.clear_marks, { desc = "MultiMark: clear all marks" })
vim.keymap.set("n", "md", M.delete_marks_ui, { desc = "MultiMark: open delete UI" })

return M
