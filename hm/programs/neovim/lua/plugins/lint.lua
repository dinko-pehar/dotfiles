return {
    "mfussenegger/nvim-lint",
    cmd = "Lint",
    config = function()
        local nvim_lint = require("lint")

        vim.api.nvim_create_user_command("Lint", function()
            nvim_lint.try_lint()
        end, {})

        local function file_exists(name)
            local f = io.open(name, "r")
            if f ~= nil then
                io.close(f)
                return true
            else
                return false
            end
        end
        local bandit = require("lint").linters.bandit
        if file_exists("bandit.yml") then
            bandit.args = {
                "-f",
                "custom",
                "-c",
                "bandit.yml",
                "--msg-template",
                "{line}:{col}:{severity}:{test_id} {msg}",
            }
        end

        nvim_lint.linters_by_ft = {
            python = { "bandit", "vulture", "flake8" },
            nix = { "nix" },
        }
    end,
}
