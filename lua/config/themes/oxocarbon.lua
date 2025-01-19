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
    end,
}
