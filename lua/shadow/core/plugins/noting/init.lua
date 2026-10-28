local M = {}

local default_config = {
	root = vim.fn.expand("~/.notes/"),
	note_extension = "md",
	templates = {
		heading = true,
	},
}

M.config = vim.tbl_deep_extend("force", {}, default_config)

local function joinpath(...)
	return vim.fs.joinpath(...)
end

local function mkdirp(path)
	vim.fn.mkdir(path, "p")
end

local function normalize(path)
	return vim.fs.normalize(path)
end

local function is_descendant(path, root)
	path = normalize(path)
	root = normalize(root)
	return path == root or path:sub(1, #root + 1) == root .. "/"
end

local function split_path(path)
	local parts = {}
	for part in path:gmatch("[^/]+") do
		parts[#parts + 1] = part
	end
	return parts
end

local function relative_path(from_dir, to_path)
	from_dir = normalize(from_dir)
	to_path = normalize(to_path)
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

local function strip_quotes(value)
	return (value:gsub([[^%s*['"]?(.-)['"]?%s*$]], "%1"))
end

local function slugify(text)
	text = vim.trim(text:lower())
	text = text:gsub("[^%w%s-]", "")
	text = text:gsub("%s+", "-")
	text = text:gsub("-+", "-")
	text = text:gsub("^%-+", ""):gsub("%-+$", "")
	return text ~= "" and text or "note"
end

local function timestamp()
	return os.date("%Y%m%d-%H%M%S")
end

local function unique_suffix()
	return string.format("%04x", math.random(0, 0xffff))
end

local function prompt_with_snacks(opts, cb)
	local snacks = rawget(_G, "Snacks")
	if snacks and snacks.input and snacks.input.input then
		snacks.input.input(opts, cb)
		return
	end
	vim.ui.input(opts, cb)
end

local function notify(msg, level)
	local snacks = rawget(_G, "Snacks")
	if snacks and snacks.notify then
		snacks.notify(msg, { level = level })
		return
	end
	vim.notify(msg, level or vim.log.levels.INFO)
end

local function ensure_root()
	mkdirp(M.config.root)
	return M.config.root
end

local function note_ext()
	return "." .. M.config.note_extension
end

local function has_note_extension(path)
	local ext = note_ext()
	return path:sub(- #ext) == ext
end

local function strip_note_extension(path)
	local ext = note_ext()
	if path:sub(- #ext) == ext then
		return path:sub(1, - #ext - 1)
	end
	return path
end

local function note_root()
	return ensure_root()
end

local function note_path_from_project(project, title)
	local root = note_root()
	local dir = root
	if project and project ~= "" then
		dir = joinpath(root, project)
	end
	mkdirp(dir)
	local base = string.format("%s-%s-%s", timestamp(), slugify(title), unique_suffix())
	return joinpath(dir, base .. note_ext())
end

local function template_lines(meta)
	local lines = {
		"---",
		string.format('title: "%s"', meta.title:gsub('"', '\\"')),
	}

	if meta.project and meta.project ~= "" then
		lines[#lines + 1] = string.format('project: "%s"', meta.project:gsub('"', '\\"'))
	end

	if meta.tags and #meta.tags > 0 then
		lines[#lines + 1] = "tags:"
		for _, tag in ipairs(meta.tags) do
			lines[#lines + 1] = string.format("  - %s", tag)
		end
	end

	lines[#lines + 1] = string.format('created: "%s"', os.date("!%Y-%m-%dT%H:%M:%SZ"))
	lines[#lines + 1] = "---"
	lines[#lines + 1] = ""
	if M.config.templates.heading then
		lines[#lines + 1] = "# " .. meta.title
		lines[#lines + 1] = ""
	end
	return lines
end

local function write_new_note(path, meta)
	local lines = template_lines(meta)
	vim.fn.writefile(lines, path)
end

local function open_file(path)
	vim.cmd.edit(vim.fn.fnameescape(path))
end

local function open_folder(path)
	if rawget(_G, "Snacks") and Snacks.explorer then
		Snacks.explorer({ cwd = path })
		return
	end
	vim.cmd.cd(vim.fn.fnameescape(path))
	vim.cmd.edit(vim.fn.fnameescape(path))
end

local function list_paths(root, filter)
	local items = {}
	local function walk(dir)
		local entries = vim.fs.dir(dir)
		if not entries then
			return
		end
		for name, t in entries do
			local path = joinpath(dir, name)
			if t == "directory" then
				if not filter or filter(path, "directory") then
					items[#items + 1] = path
				end
				walk(path)
			elseif not filter or filter(path, "file") then
				items[#items + 1] = path
			end
		end
	end

	walk(root)
	return items
end

local function note_entries()
	local root = note_root()
	local paths = list_paths(root, function(path, kind)
		return kind == "file" and has_note_extension(path)
	end)
	table.sort(paths)

	local items = {}
	for _, path in ipairs(paths) do
		local rel = normalize(path):sub(#normalize(root) + 2)
		local title = M.note_title(path) or vim.fs.basename(path)
		items[#items + 1] = {
			label = string.format("%s  —  %s", title, rel),
			path = path,
			title = title,
			relative = rel,
		}
	end
	return items
end

local function project_entries()
	local root = note_root()
	local paths = list_paths(root, function(_, kind)
		return kind == "directory"
	end)
	table.sort(paths)

	local items = {}
	for _, path in ipairs(paths) do
		local rel = normalize(path):sub(#normalize(root) + 2)
		items[#items + 1] = {
			label = rel,
			path = path,
			relative = rel,
		}
	end
	return items
end

function M.note_title(path)
	local ok, lines = pcall(vim.fn.readfile, path, "", 32)
	if not ok then
		return nil
	end

	local in_frontmatter = false
	for _, line in ipairs(lines) do
		if line == "---" then
			in_frontmatter = not in_frontmatter
		elseif in_frontmatter then
			local value = line:match("^title:%s*(.+)$")
			if value then
				return strip_quotes(value)
			end
		else
			break
		end
	end
	return nil
end

function M.relative_link(from_path, to_path)
	local from_dir = vim.fs.dirname(from_path)
	local rel = relative_path(from_dir, to_path)
	local title = M.note_title(to_path) or vim.fs.basename(to_path)
	return string.format("[%s](%s)", title, rel)
end

function M.follow_markdown_link(path, cursor_col)
	local line = vim.api.nvim_get_current_line()
	local link = nil
	for s, _, target, e in line:gmatch("()%[([^]]-)%]%(([^)]+)%)()") do
		local from = s - 1
		local to = e - 2
		if cursor_col >= from and cursor_col <= to then
			link = { target = target }
			break
		end
	end

	if not link then
		notify("Noting: cursor is not on a markdown link", vim.log.levels.WARN)
		return
	end

	local target = link.target
	local resolved = vim.fs.normalize(vim.fs.joinpath(vim.fs.dirname(path), target))
	if vim.uv.fs_stat(resolved) then
		open_file(resolved)
		return
	end

	notify("Noting: linked file not found", vim.log.levels.WARN)
end

function M.insert_link_to_note()
	local current = vim.api.nvim_buf_get_name(0)
	if current == "" then
		notify("Noting: open a note before inserting a link", vim.log.levels.WARN)
		return
	end

	local function insert_link(item)
		if not item then
			return
		end
		local basename = strip_note_extension(vim.fs.basename(item.path))
		prompt_with_snacks({
			prompt = "Link title: ",
			default = "",
		}, function(title)
			title = vim.trim(title or "")
			if title == "" then
				title = basename
			end
			local rel = relative_path(vim.fs.dirname(current), item.path)
			local link = string.format("[%s](%s)", title, rel)
			vim.api.nvim_put({ link }, "c", true, true)
		end)
	end

	vim.ui.select(note_entries(), {
		prompt = "Link note",
		format_item = function(item)
			return item.label
		end,
	}, insert_link)
end

function M.open_root()
	local snacks = rawget(_G, "Snacks")
	local root = note_root()
	if vim.fn.getcwd() ~= root then
		vim.cmd.cd(vim.fn.fnameescape(root))
	end
	if snacks and snacks.explorer then
		snacks.explorer({ cwd = root })
		return
	end
	open_folder(root)
end

function M.browse_notes()
	local snacks = rawget(_G, "Snacks")
	local root = note_root()
	if snacks and snacks.picker and snacks.picker.files then
		snacks.picker.files({ cwd = root, hidden = true })
		return
	end

	local items = note_entries()
	vim.ui.select(items, {
		prompt = "Select note",
		format_item = function(item)
			return item.label
		end,
	}, function(item)
		if item then
			open_file(item.path)
		end
	end)
end

function M.browse_projects()
	local snacks = rawget(_G, "Snacks")
	local root = note_root()
	if snacks and snacks.picker and snacks.picker.files then
		snacks.picker.files({ cwd = root, hidden = true })
		return
	end

	local items = project_entries()
	vim.ui.select(items, {
		prompt = "Select project",
		format_item = function(item)
			return item.label
		end,
	}, function(item)
		if item then
			open_file(item.path)
		end
	end)
end

function M.create_note()
	prompt_with_snacks({ prompt = "Note title: " }, function(title)
		title = title and vim.trim(title) or ""
		if title == "" then
			notify("Noting: note creation cancelled", vim.log.levels.INFO)
			return
		end

		local default_project = M.current_project()
		prompt_with_snacks({
			prompt = "Project path (optional): ",
			default = default_project,
		}, function(project)
			project = vim.trim(project or "")
			prompt_with_snacks({
				prompt = "Tags (comma-separated, optional): ",
			}, function(tags)
				local tag_list = {}
				for tag in (tags or ""):gmatch("[^,]+") do
					local cleaned = vim.trim(tag)
					if cleaned ~= "" then
						tag_list[#tag_list + 1] = cleaned
					end
				end

				local path = note_path_from_project(project, title)
				if vim.uv.fs_stat(path) then
					notify("Noting: note already exists", vim.log.levels.WARN)
					open_file(path)
					return
				end

				write_new_note(path, {
					title = title,
					project = project,
					tags = tag_list,
				})
				open_file(path)
			end)
		end)
	end)
end

function M.current_project()
	local buf = vim.api.nvim_buf_get_name(0)
	if buf == "" then
		return ""
	end
	local root = normalize(note_root())
	local current = normalize(buf)
	if not is_descendant(current, root) then
		return ""
	end
	local dir = vim.fs.dirname(current)
	local rel = dir:sub(#root + 2)
	if rel == "" or rel == dir then
		return ""
	end
	return rel
end

function M.new_project()
	prompt_with_snacks({ prompt = "Project path: " }, function(project)
		project = vim.trim(project or "")
		if project == "" then
			notify("Noting: project creation cancelled", vim.log.levels.INFO)
			return
		end
		mkdirp(joinpath(note_root(), project))
		notify("Created project " .. project, vim.log.levels.INFO)
	end)
end

function M.link_note()
	M.insert_link_to_note()
end

function M.note_buffer(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		return false
	end
	local root = normalize(note_root())
	local current = normalize(name)
	return is_descendant(current, root) and has_note_extension(current)
end

function M.attach_buffer_mappings(buf)
	if not M.note_buffer(buf) then
		return
	end
	vim.keymap.set("n", "gd", function()
		local path = vim.api.nvim_buf_get_name(0)
		local col = vim.api.nvim_win_get_cursor(0)[2]
		M.follow_markdown_link(path, col)
	end, { buffer = buf, silent = true, desc = "Follow markdown link" })
	vim.keymap.set("n", "lf", function()
		M.insert_link_to_note()
	end, { buffer = buf, silent = true, desc = "Insert note link" })
	vim.keymap.set("n", "<leader>nx", M.toggle_checkbox, { buffer = buf, silent = true, desc = "Noting: toggle checkbox" })
	vim.keymap.set("n", "]t", function() M.jump_task(1) end, { buffer = buf, silent = true, desc = "Next open task" })
	vim.keymap.set("n", "[t", function() M.jump_task(-1) end, { buffer = buf, silent = true, desc = "Previous open task" })
	vim.keymap.set("n", "<leader>nR", M.rename_note, { buffer = buf, silent = true, desc = "Noting: rename note" })
end

function M.setup_autocmds()
	local group = vim.api.nvim_create_augroup("Noting", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufNewFile" }, {
		group = group,
		callback = function(args)
			M.attach_buffer_mappings(args.buf)
		end,
	})
end

----------------------------------------------------------------------
-- project-aware notes, todos, capture
----------------------------------------------------------------------

-- Project name for the current buffer: the notes subfolder when inside the
-- notes root, otherwise the git root basename of the buffer's directory.
function M.detect_project()
	local inside = M.current_project()
	if inside ~= "" then
		return inside
	end
	local dir = vim.fn.expand("%:p:h")
	if dir == "" then
		dir = vim.fn.getcwd()
	end
	local out = vim.fn.systemlist("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel 2>/dev/null")
	if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
		return vim.fs.basename(out[1])
	end
	return ""
end

local function with_project(cb)
	local project = M.detect_project()
	if project ~= "" then
		cb(project)
		return
	end
	prompt_with_snacks({ prompt = "Project: " }, function(value)
		value = vim.trim(value or "")
		if value == "" then
			notify("Noting: no project", vim.log.levels.WARN)
			return
		end
		cb(value)
	end)
end

local function open_or_create(path, meta, body)
	mkdirp(vim.fs.dirname(path))
	if not vim.uv.fs_stat(path) then
		local lines = template_lines(meta)
		for _, l in ipairs(body or {}) do
			lines[#lines + 1] = l
		end
		vim.fn.writefile(lines, path)
	end
	open_file(path)
end

-- Fixed per-project files (notes.md / todo.md) so there is one place to go.
function M.project_note()
	with_project(function(project)
		open_or_create(joinpath(note_root(), project, "notes" .. note_ext()), {
			title = project .. " notes",
			project = project,
			tags = { "notes" },
		})
	end)
end

function M.project_todo()
	with_project(function(project)
		open_or_create(joinpath(note_root(), project, "todo" .. note_ext()), {
			title = project .. " todo",
			project = project,
			tags = { "todo" },
		}, { "- [ ] " })
	end)
end

-- Append a checkbox to the project todo without leaving the current buffer.
function M.capture_todo()
	with_project(function(project)
		prompt_with_snacks({ prompt = "Todo (" .. project .. "): " }, function(text)
			text = vim.trim(text or "")
			if text == "" then
				return
			end
			local path = joinpath(note_root(), project, "todo" .. note_ext())
			if not vim.uv.fs_stat(path) then
				mkdirp(vim.fs.dirname(path))
				local lines = template_lines({ title = project .. " todo", project = project, tags = { "todo" } })
				vim.fn.writefile(lines, path)
			end
			vim.fn.writefile({ "- [ ] " .. text }, path, "a")
			notify("Todo added to " .. project)
		end)
	end)
end

-- Append a timestamped line to the project notes (quick thought).
function M.capture_note()
	with_project(function(project)
		prompt_with_snacks({ prompt = "Note (" .. project .. "): " }, function(text)
			text = vim.trim(text or "")
			if text == "" then
				return
			end
			local path = joinpath(note_root(), project, "notes" .. note_ext())
			if not vim.uv.fs_stat(path) then
				mkdirp(vim.fs.dirname(path))
				local lines = template_lines({ title = project .. " notes", project = project, tags = { "notes" } })
				vim.fn.writefile(lines, path)
			end
			vim.fn.writefile({ string.format("- %s %s", os.date("%Y-%m-%d %H:%M"), text) }, path, "a")
			notify("Note added to " .. project)
		end)
	end)
end

function M.daily()
	local date = os.date("%Y-%m-%d")
	open_or_create(joinpath(note_root(), "daily", date .. note_ext()), {
		title = date,
		tags = { "daily" },
	})
end

----------------------------------------------------------------------
-- search / navigation
----------------------------------------------------------------------

function M.search()
	local snacks = rawget(_G, "Snacks")
	if snacks and snacks.picker and snacks.picker.grep then
		snacks.picker.grep({ cwd = note_root() })
		return
	end
	prompt_with_snacks({ prompt = "Search notes: " }, function(query)
		query = vim.trim(query or "")
		if query == "" then
			return
		end
		vim.cmd("silent! vimgrep /" .. vim.fn.escape(query, "/\\") .. "/j " .. vim.fn.fnameescape(note_root()) .. "/**/*" .. note_ext())
		vim.cmd.copen()
	end)
end

-- Fill quickfix from ripgrep output ("file:line:col:text").
local function rg_to_quickfix(pattern, title, extra)
	local cmd = { "rg", "--vimgrep", "--no-heading", "-g", "*" .. note_ext() }
	vim.list_extend(cmd, extra or {})
	vim.list_extend(cmd, { "-e", pattern, note_root() })
	local out = vim.fn.systemlist(cmd)
	if vim.v.shell_error > 1 then
		notify("Noting: rg failed", vim.log.levels.ERROR)
		return
	end
	if #out == 0 then
		notify("Noting: no matches for " .. title)
		return
	end
	vim.fn.setqflist({}, " ", { title = title, lines = out, efm = "%f:%l:%c:%m" })
	vim.cmd.copen()
end

-- Unchecked tasks across all notes; scope = "project" limits to current project.
function M.open_tasks(scope)
	local project = scope == "project" and M.detect_project() or ""
	local extra = {}
	if project ~= "" then
		extra = { "--glob", project .. "/**" }
	end
	rg_to_quickfix([[^\s*[-*] \[ \] ]], project ~= "" and ("Tasks: " .. project) or "Tasks: all", extra)
end

function M.backlinks()
	local name = vim.api.nvim_buf_get_name(0)
	if not M.note_buffer(0) then
		notify("Noting: not in a note", vim.log.levels.WARN)
		return
	end
	local base = vim.fs.basename(name)
	rg_to_quickfix("\\]\\([^)]*" .. vim.pesc(base):gsub("%%", "\\") .. "\\)", "Backlinks: " .. base, { "--glob", "!" .. base })
end

function M.search_tag()
	local tags, seen = {}, {}
	for _, item in ipairs(note_entries()) do
		local ok, lines = pcall(vim.fn.readfile, item.path, "", 32)
		if ok then
			local in_tags = false
			for _, line in ipairs(lines) do
				if line:match("^tags:") then
					in_tags = true
				elseif in_tags and line:match("^%s+%-%s+") then
					local tag = vim.trim(line:gsub("^%s+%-%s+", ""))
					if not seen[tag] then
						seen[tag] = true
						tags[#tags + 1] = tag
					end
				elseif in_tags then
					break
				end
			end
		end
	end
	table.sort(tags)
	if #tags == 0 then
		notify("Noting: no tags found")
		return
	end
	vim.ui.select(tags, { prompt = "Tag" }, function(tag)
		if tag then
			rg_to_quickfix("^\\s+- " .. tag .. "$", "Tag: " .. tag)
		end
	end)
end

function M.recent()
	local items = note_entries()
	for _, item in ipairs(items) do
		local stat = vim.uv.fs_stat(item.path)
		item.mtime = stat and stat.mtime.sec or 0
	end
	table.sort(items, function(a, b)
		return a.mtime > b.mtime
	end)
	vim.ui.select(vim.list_slice(items, 1, 30), {
		prompt = "Recent notes",
		format_item = function(item)
			return string.format("%s  %s", os.date("%m-%d %H:%M", item.mtime), item.label)
		end,
	}, function(item)
		if item then
			open_file(item.path)
		end
	end)
end

-- Pick a project folder, then browse its files.
function M.pick_project()
	local items = project_entries()
	if #items == 0 then
		notify("Noting: no projects yet")
		return
	end
	vim.ui.select(items, {
		prompt = "Select project",
		format_item = function(item)
			return item.label
		end,
	}, function(item)
		if not item then
			return
		end
		local snacks = rawget(_G, "Snacks")
		if snacks and snacks.picker and snacks.picker.files then
			snacks.picker.files({ cwd = item.path, hidden = true })
		else
			open_folder(item.path)
		end
	end)
end

function M.rename_note()
	local path = vim.api.nvim_buf_get_name(0)
	if not M.note_buffer(0) then
		notify("Noting: not in a note", vim.log.levels.WARN)
		return
	end
	prompt_with_snacks({ prompt = "New file name: ", default = strip_note_extension(vim.fs.basename(path)) }, function(name)
		name = vim.trim(name or "")
		if name == "" then
			return
		end
		local target = joinpath(vim.fs.dirname(path), strip_note_extension(name) .. note_ext())
		if vim.uv.fs_stat(target) then
			notify("Noting: target exists", vim.log.levels.WARN)
			return
		end
		vim.cmd.write()
		if vim.fn.rename(path, target) ~= 0 then
			notify("Noting: rename failed", vim.log.levels.ERROR)
			return
		end
		vim.cmd.edit(vim.fn.fnameescape(target))
		vim.cmd("bwipeout! " .. vim.fn.bufnr(path))
		notify("Renamed (links to it are not updated)")
	end)
end

----------------------------------------------------------------------
-- checkbox helpers (buffer-local)
----------------------------------------------------------------------

local states = { " ", "x" }

function M.toggle_checkbox()
	local lnum = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
	local new
	if line:match("^%s*[-*] %[.%]") then
		local cur = line:match("^%s*[-*] %[(.)%]")
		new = line:gsub("%[.%]", cur == states[2] and "[ ]" or "[x]", 1)
	elseif line:match("^%s*[-*] ") then
		new = line:gsub("^(%s*[-*]) ", "%1 [ ] ", 1)
	else
		new = line:gsub("^(%s*)", "%1- [ ] ", 1)
	end
	vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { new })
end

-- Move to next/previous open checkbox in buffer.
function M.jump_task(dir)
	local flags = dir < 0 and "bW" or "W"
	if vim.fn.search([=[^\s*[-*] \[ \]]=], flags) == 0 then
		notify("Noting: no more open tasks")
	end
end

----------------------------------------------------------------------
-- commands and keymaps
----------------------------------------------------------------------

local subcommands = {
	new = M.create_note,
	project = M.project_note,
	todo = M.project_todo,
	capture = M.capture_todo,
	quick = M.capture_note,
	daily = M.daily,
	search = M.search,
	tasks = function() M.open_tasks("all") end,
	ptasks = function() M.open_tasks("project") end,
	backlinks = M.backlinks,
	tags = M.search_tag,
	recent = M.recent,
	browse = M.browse_notes,
	projects = M.pick_project,
	newproject = M.new_project,
	root = M.open_root,
	rename = M.rename_note,
	link = M.insert_link_to_note,
}

local default_keys = {
	["<leader>nn"] = { "new", "New note" },
	["<leader>np"] = { "project", "Project notes" },
	["<leader>nt"] = { "todo", "Project todo" },
	["<leader>nc"] = { "capture", "Capture todo" },
	["<leader>nq"] = { "quick", "Quick note" },
	["<leader>nd"] = { "daily", "Daily note" },
	["<leader>ns"] = { "search", "Search notes" },
	["<leader>nT"] = { "tasks", "All open tasks" },
	["<leader>nP"] = { "ptasks", "Project open tasks" },
	["<leader>nb"] = { "backlinks", "Backlinks" },
	["<leader>ng"] = { "tags", "Notes by tag" },
	["<leader>nr"] = { "recent", "Recent notes" },
	["<leader>nf"] = { "browse", "Browse notes" },
	["<leader>nF"] = { "projects", "Browse project" },
	["<leader>no"] = { "root", "Notes explorer" },
}

function M.setup_commands()
	vim.api.nvim_create_user_command("Noting", function(args)
		local fn = subcommands[args.args ~= "" and args.args or "browse"]
		if not fn then
			notify("Noting: unknown subcommand " .. args.args, vim.log.levels.WARN)
			return
		end
		fn()
	end, {
		nargs = "?",
		desc = "Noting commands",
		complete = function(lead)
			local names = vim.tbl_keys(subcommands)
			table.sort(names)
			return vim.tbl_filter(function(n)
				return vim.startswith(n, lead)
			end, names)
		end,
	})

	if M.config.keymaps == false then
		return
	end
	local keys = vim.tbl_extend("force", default_keys, M.config.keymaps or {})
	for lhs, spec in pairs(keys) do
		if spec then
			vim.keymap.set("n", lhs, subcommands[spec[1]], { silent = true, desc = "Noting: " .. spec[2] })
		end
	end
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", {}, default_config, opts or {})
	math.randomseed(vim.uv.hrtime() % 4294967295)
	ensure_root()
	M.setup_autocmds()
	M.setup_commands()
end

return M
