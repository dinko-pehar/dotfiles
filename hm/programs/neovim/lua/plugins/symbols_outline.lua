return {
    "simrat39/symbols-outline.nvim",
    keys = "<F8>",
    config = function()
        require("symbols-outline").setup({
            width = 15,
            show_symbol_details = false,
            autofold_depth = 0,
            keymaps = { -- These keymaps can be a string or a table for multiple keys
                close = { "<Esc>", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "<C-space>",
                toggle_preview = "K",
                rename_symbol = "r",
                code_actions = "a",
                fold = "h",
                unfold = "l",
                fold_all = "W",
                unfold_all = "E",
                fold_reset = "R",
            },
        })

        vim.api.nvim_set_keymap("n", "<F8>", ":SymbolsOutline<cr>", { silent = true, noremap = true })
    end,
}
