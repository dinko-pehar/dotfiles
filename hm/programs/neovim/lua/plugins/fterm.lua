return {
    "numToStr/FTerm.nvim",
    config = function()
        local fterm = require("FTerm")

        local term_1 = fterm:new({
            ft = "Terminal_1",
            dimensions = { width = 0.5, height = 0.7 },
            border = "double",
        })
        local term_2 = fterm:new({
            ft = "Terminal_2",
            dimensions = { width = 0.5, height = 0.7 },
            border = "double",
        })

        -- Example keybindings, allows creating 2 terminals.
        vim.keymap.set("n", "<F3>", function()
            term_1:toggle()
        end)
        vim.keymap.set("t", "<F3>", function()
            term_1:toggle()
        end)
        vim.keymap.set("n", "<leader><F3>", function()
            term_2:toggle()
        end)
        vim.keymap.set("t", "<leader><F3>", function()
            term_2:toggle()
        end)
    end,
}
