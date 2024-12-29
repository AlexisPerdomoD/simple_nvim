return {
    "zootedb0t/citruszest.nvim",
    lazy = true,
    config = require("citruszest").setup({
        option = {
            transparent = false, -- Enable/Disable transparency
            bold = false,
            italic = true,
        }

    })
}
