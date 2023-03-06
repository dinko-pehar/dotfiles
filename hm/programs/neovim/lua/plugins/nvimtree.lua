return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local nvim_tree = require("nvim-tree")

        nvim_tree.setup({
            filters = { custom = { "^\\.git$" } },
            live_filter = {
                prefix = "[FILTER]: ",
                always_show_folders = true,
            },
            view = { hide_root_folder = true },
            renderer = { icons = { git_placement = "after" } },
            actions = { open_file = { quit_on_open = false } },
            tab = { sync = { open = true, close = true, ignore = {} } },
        })
        -- Focus on NVim-Tree
        vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeFocus<cr>", { silent = true, noremap = true })
        -- Closes NVim-Tree if open
        vim.api.nvim_set_keymap("n", "<leader><F2>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

        local function tab_win_closed(winnr)
            local api = require("nvim-tree.api")
            local tabnr = vim.api.nvim_win_get_tabpage(winnr)
            local bufnr = vim.api.nvim_win_get_buf(winnr)
            local buf_info = vim.fn.getbufinfo(bufnr)[1]
            local tab_wins = vim.tbl_filter(function(w)
                return w ~= winnr
            end, vim.api.nvim_tabpage_list_wins(tabnr))
            local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
            if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
                -- Close all nvim tree on :q
                if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
                    api.tree.close()
                end
            else -- else closed buffer was normal buffer
                if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
                    local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
                    if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
                        vim.schedule(function()
                            if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
                                vim.cmd("quit") -- then close all of vim
                            else -- else there are more tabs open
                                vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
                            end
                        end)
                    end
                end
            end
        end

        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function(data)
                -- buffer is a [No Name]
                local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

                -- buffer is a directory
                local directory = vim.fn.isdirectory(data.file) == 1

                if not no_name and not directory then
                    return
                end

                -- change to the directory
                if directory then
                    vim.cmd.cd(data.file)
                end

                -- open the tree
                require("nvim-tree.api").tree.open()
            end,
        })
        vim.api.nvim_create_autocmd("WinClosed", {
            callback = function()
                local winnr = tonumber(vim.fn.expand("<amatch>"))
                vim.schedule_wrap(tab_win_closed(winnr))
            end,
            nested = true,
        })
    end,
    tag = "nightly", -- optional, updated every week. (see issue #1193)
}
