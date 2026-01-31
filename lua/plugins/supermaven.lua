local M = { 'supermaven-inc/supermaven-nvim' }
M.lazy = false

M.config = function()
    require 'supermaven-nvim'.setup {
        keymaps = {
            accept_suggestion = '<C-a>',
            clear_suggestion = '<C-]>',
            accept_word = '<C-w>',
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
            -- suggestion_color = "#ffffff",
            -- cterm = 244,
        },
        log_level = 'off',                 -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
    }

    local api = require 'supermaven-nvim.api'
    api.use_free_version()
    api.restart()

    vim.api.nvim_create_autocmd("User", {
        pattern = "ConformFormatPre",
        callback = function()
            if api.is_running() then
                api.stop()
            end
        end,
    })

    vim.api.nvim_create_autocmd("User", {
        pattern = "ConformFormatPost",
        callback = function()
            if not api.is_running() then
                api.start()
            end
        end,
    })

    -- api.start()
end

return M
-- :SupermavenStart    start supermaven-nvim
-- :SupermavenStop     stop supermaven-nvim
-- :SupermavenRestart  restart supermaven-nvim
-- :SupermavenToggle   toggle supermaven-nvim
-- :SupermavenStatus   show status of supermaven-nvim
-- :SupermavenUseFree  switch to the free version
-- :SupermavenUsePro   switch to the pro version
-- :SupermavenLogout   log out of supermaven
-- :SupermavenShowLog  show logs for supermaven-nvim
-- :SupermavenClearLog clear logs for supermaven-nvim
--
-- local api = require("supermaven-nvim.api")
--
-- api.start() -- starts supermaven-nvim
-- api.stop() -- stops supermaven-nvim
-- api.restart() -- restarts supermaven-nvim if it is running, otherwise starts it
-- api.toggle() -- toggles supermaven-nvim
-- api.is_running() -- returns true if supermaven-nvim is running
-- api.use_free_version() -- switch to the free version
-- api.use_pro() -- switch to the pro version
-- api.logout() -- log out of supermaven
-- api.show_log() -- show logs for supermaven-nvim
-- api.clear_log() -- clear logs for supermaven-nvim
