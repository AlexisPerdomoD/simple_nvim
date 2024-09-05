return {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    -- priority = 1000,
    lazy = true, 
    config = function()
        -- require("oxocarbon").setup()
        vim.opt.background = 'dark'
        vim.cmd 'colorscheme oxocarbon'
         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
