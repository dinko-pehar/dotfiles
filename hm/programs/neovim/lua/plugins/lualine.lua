return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- Override theme
        local theme = require("lualine.themes.material")
        local horizon_theme = require("lualine.themes.horizon")
        theme.normal.a.bg = horizon_theme.normal.a.bg
        require("lualine").setup({
            options = { theme = theme, globalstatus = true },
            sections = {
                lualine_a = {
                    { "mode", separator = "", padding = 3 },
                    {
                        function()
                            local mode_code = vim.api.nvim_get_mode().mode
                            if mode_code == "n" then
                                return "🐵"
                            elseif mode_code == "i" then
                                return "🙊"
                            else
                                return "🐒"
                            end
                        end,
                        separator = { left = "" },
                        color = { bg = "white" },
                    },
                },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        cond = function()
                            local name = vim.fn.expand("%:p")
                            if name:find("term") then
                                return false
                            end
                            return true
                        end,
                        on_click = function()
                            require("telescope.builtin").find_files()
                        end,
                    },
                    {
                        "filesize",
                        color = "WarningMsg",
                        cond = function()
                            local file = vim.fn.expand("%:p")
                            if file == nil or #file == 0 then
                                return false
                            end
                            local size = vim.fn.getfsize(file)
                            if size <= 0 then
                                return false
                            end

                            -- I guess this is around 500 LOCs
                            if size > 1024 * 20 then
                                return true
                            end
                        end,
                    },
                },
                lualine_x = {
                    { "encoding", separator = "|" },
                    { "fileformat", separator = "|" },
                    { "filetype" },
                },
                lualine_y = { { 'os.date("%H:%M")' } },
                lualine_z = {
                    { "progress", separator = { left = "" }, padding = 2 },
                },
            },
            tabline = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { { "tabs", mode = 0 } }, -- NOTE: This can be set later for renaming tabs.
            },
            extensions = { "nvim-tree", "symbols-outline" },
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
