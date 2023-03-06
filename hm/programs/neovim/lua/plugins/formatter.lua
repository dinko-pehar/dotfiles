return {
    "mhartington/formatter.nvim",
    cmd = { "Format", "FormatWrite" },
    config = function()
        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = function()
                    local util = require("formatter.util")
                    return {
                        exe = "stylua",
                        args = {
                            "--search-parent-directories",
                            "--indent-type=Spaces",
                            "--stdin-filepath",
                            util.escape_path(util.get_current_buffer_file_path()),
                            "--",
                            "-",
                        },
                        stdin = true,
                    }
                end,
                nix = { require("formatter.filetypes.nix").nixfmt },
                json = { require("formatter.filetypes.json").jq },
                python = { require("formatter.filetypes.python").black },
                ruby = { require("formatter.filetypes.ruby").rubocop },
                rust = { require("formatter.filetypes.rust").rustfmt },
                toml = { require("formatter.filetypes.toml").taplo },
            },
        })
    end,
}
