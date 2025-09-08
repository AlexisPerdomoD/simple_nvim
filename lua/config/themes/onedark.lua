return {
    'navarasu/onedark.nvim',
    lazy = true,
    config = function()
        vim.cmd 'colorscheme onedark'
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end,
}
