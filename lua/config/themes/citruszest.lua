return {
    "zootedb0t/citruszest.nvim",
    lazy = true,
    -- priority = 1000,
    config =
        function()
            require("citruszest").setup({
                option = {
                    transparent = true, -- Enable/Disable transparency
                    bold = false,
                    italic = true,
                }

            })
            vim.cmd [[ colorscheme citruszest ]]
        end
}
