return {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
        vim.cmd 'colorscheme onedark'
        require('utils.bg_color_setuper').bg_setuper(false, true)
    end
}
