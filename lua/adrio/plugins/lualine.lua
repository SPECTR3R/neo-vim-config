return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local lspStatus = {
			function()
				local msg = "No LSP"
				local buf_ft = vim.api.nvim_get_option_value("filetype", {})
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = "",
			color = { fg = "#0E1219" },
		}

		local buffer = {
			"buffers",
			mode = 0,
			show_filename_only = true,
			show_modified_status = true,
			hide_filename_extension = false,
			symbols = { alternate_file = "" },
			buffers_color = {
				active = { fg = "#d3d3d3" },
				inactive = { fg = "#757575" },
			},
		}

		local diagnostic = {
			"diagnostics",
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			},
			update_in_insert = false, -- Update diagnostics in insert mode.
		}

		local diff = {
			"diff",
			colored = false,
		}
		local colors = {
			color2 = "#242b38",
			color3 = "#d4bfff",
			color4 = "#d9d7ce",
			color5 = "#272d38",
			color13 = "#bbe67e",
			color10 = "#59c2ff",
			color8 = "#f07178",
			color9 = "#607080",
		}
		return {
			options = {
				icons_enabled = true,
				theme = "ayu_mirage",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "lazy" },
				always_divide_middle = true,
				globalstatus = true,
			},
			always_divide_middle = true,
			sections = {
				lualine_a = {
					{
						"mode",
					},
					"branch",
					diff,
				},
				lualine_b = { buffer },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { diagnostic },
				lualine_z = {
					lspStatus,
					{
						"filetype",
						icons_enabled = false,
						separator = { left = "", right = "" }, -- Determines what separator to use for the component.
					},
				},
			},
		}
	end,
}
