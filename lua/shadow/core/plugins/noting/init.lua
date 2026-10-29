local M = {}

local ROOT = vim.fs.normalize("~/.notes")

-- Checkbox states, cycled in order.
local states = { " ", "-", "x" }

local function notify(msg, level)
	vim.notify("Noting: " .. msg, level or vim.log.levels.INFO)
end

local function is_note(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	return name ~= "" and vim.endswith(name, ".md") and vim.startswith(vim.fs.normalize(name), ROOT .. "/")
end

local function split_path(path)
	local parts = {}
	for part in path:gmatch("[^/]+") do
		parts[#parts + 1] = part
	end
	return parts
end

local function relative_path(from_dir, to_path)
	local from_parts = split_path(from_dir)
	local to_parts = split_path(to_path)
	local i = 1
	while from_parts[i] and to_parts[i] and from_parts[i] == to_parts[i] do
		i = i + 1
	end

	local rel = {}
	for _ = i, #from_parts do
		rel[#rel + 1] = ".."
	end
	for j = i, #to_parts do
		rel[#rel + 1] = to_parts[j]
	end
	return table.concat(rel, "/")
end

local function note_files()
	local files = {}
	for path, kind in vim.fs.dir(ROOT, { depth = math.huge }) do
		if kind == "file" and vim.endswith(path, ".md") then
			files[#files + 1] = vim.fs.joinpath(ROOT, path)
		end
	end
	table.sort(files)
	return files
end

-- Insert "# Title" / "Created on: date" at the top unless the note has a heading.
function M.insert_header()
	local first = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
	if first:match("^# ") then
		notify("header already present", vim.log.levels.WARN)
		return
	end
	local title = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r"):gsub("[-_]+", " ")
	local header = { "# " .. title, "Created on: " .. os.date("%Y-%m-%d") }
	if first ~= "" then
		header[#header + 1] = ""
	end
	vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

-- Ask for a note under ~/.notes, insert [](relative/path.md), cursor inside [].
function M.link_note()
	local from_dir = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(0)))
	local files = note_files()
	if #files == 0 then
		notify("no notes found", vim.log.levels.WARN)
		return
	end

	vim.ui.select(files, {
		prompt = "Link note",
		format_item = function(path)
			return path:sub(#ROOT + 2)
		end,
	}, function(path)
		if not path then
			return
		end
		local link = string.format("[](%s)", relative_path(from_dir, path))
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		vim.api.nvim_put({ link }, "c", true, true)
		-- "c" put after cursor: link starts at col + 1 (or col on an empty line)
		local line = vim.api.nvim_get_current_line()
		local start = line:find("[](", col, true) or 1
		vim.api.nvim_win_set_cursor(0, { row, start })
		vim.cmd.startinsert()
	end)
end

-- Insert "- [ ] " on the current line if empty, else on a new line below.
function M.new_checkbox()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local text = "- [ ] "
	if line:match("^%s*$") then
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { text })
	else
		row = row + 1
		vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { text })
	end
	vim.api.nvim_win_set_cursor(0, { row, #text })
	vim.cmd.startinsert({ bang = true })
end

-- Cycle checkbox state on the current line; otherwise behave like <CR>.
function M.toggle_checkbox()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local prefix, cur, rest = line:match("^(%s*[-*] %[)(.)(%].*)$")
	if not prefix then
		vim.api.nvim_feedkeys(vim.keycode("<CR>"), "n", false)
		return
	end
	local idx = 0
	for i, s in ipairs(states) do
		if s == cur then
			idx = i
		end
	end
	local next_state = states[idx % #states + 1]
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, { prefix .. next_state .. rest })
end

-- Open the markdown link under the cursor; otherwise fall back to LSP definition.
function M.follow_link()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	for s, target, e in line:gmatch("()%[[^%]]*%]%(([^)]+)%)()") do
		if col >= s - 1 and col <= e - 2 then
			target = target:gsub("#.*$", "")
			local dir = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(0)))
			local path = vim.fs.normalize(vim.fs.joinpath(dir, target))
			if vim.uv.fs_stat(path) then
				vim.cmd.edit(vim.fn.fnameescape(path))
			else
				notify("linked file not found: " .. target, vim.log.levels.WARN)
			end
			return
		end
	end
	vim.lsp.buf.definition()
end

local function attach(buf)
	if not is_note(buf) then
		return
	end
	local function map(mode, lhs, fn, desc)
		vim.keymap.set(mode, lhs, fn, { buffer = buf, silent = true, desc = "Noting: " .. desc })
	end
	map("n", "<leader>nh", M.insert_header, "insert header")
	map("n", "<leader>nl", M.link_note, "link note")
	map("n", "<leader>nc", M.new_checkbox, "new checkbox")
	map("n", "<CR>", M.toggle_checkbox, "toggle checkbox")
	map("n", "gd", M.follow_link, "follow link")
end

function M.setup()
	vim.fn.mkdir(ROOT, "p")
	-- LspAttach too: LSP's own buffer-local gd would otherwise override ours.
	vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufNewFile", "LspAttach" }, {
		group = vim.api.nvim_create_augroup("Noting", { clear = true }),
		callback = function(args)
			attach(args.buf)
		end,
	})
end

return M
