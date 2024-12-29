-- mellifluous. Dark and light, original.
-- alduin. Dark, link to original.
-- mountain. Dark, link to original.
-- tender. Dark, link to original.
-- kanagawa_dragon. Dark, link to original.


return {
    "ramojus/mellifluous.nvim",
    lazy = true,
    config = function()
        require("mellifluous").setup {
            styles = {
                main_keywords = { bold = true }
            }

        }
        vim.cmd("colorscheme mellifluous")
    end,
}
