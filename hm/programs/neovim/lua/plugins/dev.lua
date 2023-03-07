return {
    {
        "Pocco81/auto-save.nvim",
        -- HOTFIX:Enable autosave callbacks to format when it is fixed
        config = true
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "BufRead",
        -- NOTE: :TodoTelescope command is supported along with keywords
        -- Example > :TodoTelescope keywords=TODO,FIX
        opts = {
            signs = true,
            keywords = {
                FIX = {
                    -- a set of other keywords that all map to this FIX keywords
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "HOTFIX" },
                },
            },
        },
    },
    {
        "Exafunction/codeium.vim",
        keys={{"<C-g>", mode="i"}},
        config = function()

            vim.g.codeium_disable_bindings = 1
            vim.g.codeium_manual = 1
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set("i", "<C-g>", function()
                return vim.fn["codeium#Complete"]()
            end, { expr = true })
            vim.keymap.set("i", "<Tab>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true })
            vim.keymap.set("i", "<c-,>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true })
            vim.keymap.set("i", "<c-x>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true })
        end,
    },
    { "lewis6991/gitsigns.nvim", opts = { show_deleted = true }, event = "BufRead" },
    { "numToStr/Comment.nvim", config = true, event = "InsertEnter" },
    { "LnL7/vim-nix", ft = "nix" },
    { "Glench/Vim-Jinja2-Syntax", ft = { "jinja" } },
    { "LudoPinelli/comment-box.nvim", event = "BufRead" },
    { "windwp/nvim-autopairs", config = true, event = "BufRead" },
    {
        "lifepillar/vim-gruvbox8",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme gruvbox8]])
        end,
    },
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        event = "BufRead",
        config = function()
            require("leap").add_default_mappings()
        end,
    }
}
