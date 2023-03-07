return {
    "gelguy/wilder.nvim",
    build = "UpdateRemotePlugins",
    config = function()
        local wilder = require("wilder")
        -- Set up Wilder modes (Command and search).
        local modes = { modes = { ":", "/" } }
        wilder.setup(modes)

        -- Pipelines define how each of the modes would use it's filters.
        -- Similar to Signals, Hooks or Events callbacks based on
        -- particular mode.
        wilder.set_option("pipeline", {
            wilder.branch(
                wilder.python_file_finder_pipeline({
                    ---@diagnostic disable-next-line: unused-local
                    file_command = function(ctx, arg)
                        if string.find(arg, ".") ~= nil then
                            return { "rg", "--files" }
                        else
                            return { "rg", "--files" }
                        end
                    end,
                    dir_command = { "fd", "-td" },
                    filters = { "fuzzy_filter", "difflib_sorter" },
                    debounce = 10,
                }),
                wilder.cmdline_pipeline({
                    -- sets the language to use, 'vim' and 'python' are supported
                    language = "vim",
                    -- 0 turns off fuzzy matching
                    -- 1 turns on fuzzy matching
                    -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
                    fuzzy = 2,
                }),
                wilder.python_search_pipeline({
                    -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
                    pattern = wilder.python_fuzzy_delimiter_pattern(),
                    -- omit to get results in the order they appear in the buffer
                    sorter = wilder.python_difflib_sorter(),
                    engine = "re",
                })
            ),
        })

        -- This is how Command mode should display.
        local command_mode = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            border = "rounded",
            empty_message = wilder.popupmenu_empty_message_with_spinner(),
            highlights = {
                accent = wilder.make_hl("WilderAccent", "Pmenu", {
                    { a = 2 },
                    { a = 2 },
                    { foreground = "#fe8019", italic = true },
                }),
            },
            highlighter = { wilder.lua_fzy_highlighter() },
            left = {
                " ",
                wilder.popupmenu_devicons(),
                wilder.popupmenu_buffer_flags({
                    flags = " a + ",
                    icons = { ["+"] = "", a = "", h = "" },
                }),
            },
            right = { " ", wilder.popupmenu_scrollbar() },
        }))

        -- This is how search mode should display.
        local search_mode = wilder.wildmenu_renderer({
            highlighter = { wilder.lua_fzy_highlighter() },
            highlights = {
                accent = wilder.make_hl("WilderAccent", "Pmenu", {
                    { a = 1 },
                    { a = 1 },
                    { foreground = "#fe8019", italic = true },
                }),
            },
            separator = " § ",
            left = { " ", wilder.wildmenu_spinner(), " " },
            right = { " ", wilder.wildmenu_index() },
        })

        wilder.set_option(
            "renderer",
            wilder.renderer_mux({
                [":"] = command_mode,
                ["/"] = search_mode,
                substitute = search_mode,
            })
        )
    end,
    dependencies = { "romgrk/fzy-lua-native" },
}
