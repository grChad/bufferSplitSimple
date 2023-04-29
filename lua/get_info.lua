local web_devicons = require('nvim-web-devicons')

local M = {}
function M.get_icon_color(filename, extension)
	local file_icon = ''
	local icon_color = ''
	local default_file_icon = ''
	local default_icon_color = '#A6D189'

	if filename ~= nil then
		if extension == nil then
			extension = ''
		end

		file_icon, icon_color = web_devicons.get_icon_color(filename, extension, { default = true })

		if file_icon == nil then
			file_icon = default_file_icon
			icon_color = default_icon_color
		end
		return {
			icon = file_icon .. ' ',
			color = icon_color,
		}
	end
end

return M
