return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "help", "query", "svelte", "nix", "python", "html" },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            highlight = {
                disable = { "lua", "python" },
                enable = true,
            },
            autotag = {
                enable = true,
            },
        })
    end,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
}
