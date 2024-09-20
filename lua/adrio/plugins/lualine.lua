-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     local lualine = require("lualine")
--     local lazy_status = require("lazy.status") -- to configure lazy pending updates count
--
--     local colors = {
--       blue = "#65D1FF",
--       green = "#3EFFDC",
--       violet = "#FF61EF",
--       yellow = "#FFDA7B",
--       red = "#FF4A4A",
--       fg = "#c3ccdc",
--       bg = "#112638",
--       inactive_bg = "#2c3043",
--     }
--
--     local my_lualine_theme = {
--       normal = {
--         a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       insert = {
--         a = { bg = colors.green, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       visual = {
--         a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       command = {
--         a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       replace = {
--         a = { bg = colors.red, fg = colors.bg, gui = "bold" },
--         b = { bg = colors.bg, fg = colors.fg },
--         c = { bg = colors.bg, fg = colors.fg },
--       },
--       inactive = {
--         a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
--         b = { bg = colors.inactive_bg, fg = colors.semilightgray },
--         c = { bg = colors.inactive_bg, fg = colors.semilightgray },
--       },
--     }
--
--     -- configure lualine with modified theme
--     lualine.setup({
--       options = {
--         theme = my_lualine_theme,
--       },
--       sections = {
--         lualine_x = {
--           {
--             lazy_status.updates,
--             cond = lazy_status.has_updates,
--             color = { fg = "#ff9e64" },
--           },
--           { "encoding" },
--           { "fileformat" },
--           { "filetype" },
--         },
--       },
--     })
--   end,
-- }

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local git_blame = require("gitblame")
-- 		require("lualine").setup({
-- 			options = {
-- 				icons_enabled = true,
-- 				theme = "rose-pine",
-- 				component_separators = { left = "", right = "" },
-- 				section_separators = { left = "", right = "" },
-- 				disabled_filetypes = {
-- 					statusline = {
-- 						"neo-tree",
-- 					},
-- 					winbar = {},
-- 				},
-- 				ignore_focus = {},
-- 				always_divide_middle = true,
-- 				globalstatus = false,
-- 				refresh = {
-- 					statusline = 1000,
-- 					tabline = 1000,
-- 					winbar = 1000,
-- 				},
-- 			},
-- 			sections = {
-- 				lualine_a = { "mode" },
-- 				lualine_b = { "branch", "diff", "diagnostics" },
-- 				lualine_c = { "filename" },
-- 				lualine_x = {
-- 					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
-- 					"filetype",
-- 				},
-- 				lualine_y = { "progress" },
-- 				lualine_z = { "location" },
-- 			},
-- 			inactive_sections = {
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_c = { "filename" },
-- 				lualine_x = { "location" },
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 			},
-- 			tabline = {},
-- 			winbar = {},
-- 			inactive_winbar = {},
-- 			extensions = {},
-- 		})
-- 	end,
-- }
--
--
--
--
--
return {
	"nvim-lualine/lualine.nvim",
	opts = function()
		local lspStatus = {
			function()
				local msg = "No LSP detected"
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
			color = { fg = "#dd3aaa" },
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
			icon = "|",
		}

		local diff = {
			"diff",
			symbols = {
				added = " ",
				modified = " ",
				removed = " ",
			},
		}

		return {
			options = {
				icons_enabled = true,
				theme = "ayu_mirage",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "lazy" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { buffer },
				lualine_x = { diff, diagnostic },
				lualine_z = { lspStatus, "filetype", "location" },
				-- lualine_y = { "progress" },
			},
		}
	end,
}
