--  +----------------------------------------------------------+
--  |                           Fun                            |
--  +----------------------------------------------------------+
return {
    { "nvim-treesitter/nvim-treesitter", event = "BufRead" },
    { "Eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton" },
    { "m4xshen/smartcolumn.nvim", opts = { "100" }, event = "BufRead" },
    {
        "karb94/neoscroll.nvim",
        opts = { hide_cursor = true, easing_function = "sine" },
        event = "WinScrolled",
    },
    -- FIX: Specifiying a line still displays Wilder output. This is due to Wilder.
    { "nacro90/numb.nvim", config = true, event = "BufRead" },
    {
        "alpertuna/vim-header",
        cmd = function(_, cmds)
            local commands = { "AddHeader", "AddMinHeader" }

            for _, value in ipairs({ "MIT", "Apache", "GNU", "AGP", "LGPL", "MPL", "WTFPL", "Zlib" }) do
                table.insert(commands, "Add" .. value .. "License")
            end
            return commands
        end,
        init = function()
            vim.g.header_field_author = "Dinko"
            vim.g.header_field_author_email = "dinko@pehar.dev"
            vim.g.header_field_modified_timestamp = 0
            vim.g.header_field_modified_by = 0
            vim.g.header_field_timestamp_format = "%Y.%m.%d"
        end,
    },
}
