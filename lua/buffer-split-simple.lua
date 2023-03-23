local web_devicons = require('nvim-web-devicons')

local get_icon = function(filename, extension)
	local file_icon = ''
	local default_file_icon = ''

	if filename ~= nil then
		if extension == nil then
			extension = ''
		end

		file_icon, _ = web_devicons.get_icon_color(filename, extension)

		if file_icon == nil then
			file_icon = default_file_icon
		end
		return file_icon .. ' '
	end
end

-- holds any currently open floating windows displaying buffer tags
local M = {}
local float_wins = {}

local lista_aux = {}

local create_tag_float = function(parent_win)
	local buf = vim.api.nvim_win_get_buf(parent_win)
	local buf_name = vim.api.nvim_buf_get_name(buf)

	if #buf_name <= 0 then
		return
	else
		for item in string.gmatch(buf_name, '%a+') do
			table.insert(lista_aux, item)
		end
	end

	local file_name = lista_aux[#lista_aux - 1]
	local file_type = lista_aux[#lista_aux]

	buf_name = ' ' .. get_icon(file_name, file_type) .. file_name .. '.' .. file_type

	-- only consider normal buffers with files loaded into them.
	if vim.api.nvim_buf_get_option(buf, 'buftype') ~= '' then
		return
	end

	local buf2 = vim.api.nvim_create_buf(false, true)
	if buf2 == 0 then
		vim.api.nvim_err_writeln('details_popup: could not create details buffer')
		return nil
	end
	vim.api.nvim_buf_set_option(buf2, 'bufhidden', 'delete')
	vim.api.nvim_buf_set_option(buf2, 'modifiable', true)
	vim.api.nvim_buf_set_lines(buf2, 0, 0, false, { buf_name })
	vim.api.nvim_buf_set_option(buf2, 'modifiable', false)

	local popup_conf = {
		relative = 'win',
		anchor = 'NE',
		win = parent_win,
		width = #buf_name,
		height = 1,
		focusable = false,
		zindex = 1,
		style = 'minimal',
		border = 'rounded',
		row = 0,
		col = vim.api.nvim_win_get_width(parent_win),
	}
	local float_win = vim.api.nvim_open_win(buf2, false, popup_conf)
	table.insert(float_wins, float_win)
end

function M.display_buffertags()
	local cur_win = vim.api.nvim_get_current_win()
	local wins_to_tag = {}
	M.remove_buffertags()
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if w ~= cur_win then
			table.insert(wins_to_tag, w)
		end
	end
	for _, w in ipairs(wins_to_tag) do
		create_tag_float(w)
	end
end

function M.remove_buffertags()
	for _, float in ipairs(float_wins) do
		if vim.api.nvim_win_is_valid(float) then
			vim.api.nvim_win_close(float, true)
		end
	end
	float_wins = {}
end

local au_id = nil

local enabled = false

function M.enable()
	au_id = vim.api.nvim_create_autocmd({ 'WinEnter' }, { callback = M.display_buffertags })
	enabled = true
	-- run it so an initial window move isn't necessary
	M.display_buffertags()
end

function M.disable()
	if au_id ~= nil then
		vim.api.nvim_del_autocmd(au_id)
	end
	enabled = false
	M.remove_buffertags()
end

function M.toggle()
	if enabled then
		M.disable()
	else
		M.enable()
	end
end

function M.setup()
	vim.api.nvim_create_user_command('BuffertagToggle', M.toggle, {
		desc = 'Toggle the Buffertag feature on and off.',
	})

	M.toggle()
end

return M
