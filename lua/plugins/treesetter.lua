local M = { 'nvim-treesitter/nvim-treesitter' }
M.event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' }
M.build = ':TSUpdate'

local installing = {}

---@param buf number
---@param lang string
M.enable = function(buf, lang)
    local could_exec = pcall(vim.treesitter.start, buf, lang)
    if not could_exec then
        vim.notify('Failed to start ' .. lang, vim.log.levels.ERROR)
        return
    end
    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.wo[win].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[win].foldmethod = 'expr'
    end
end

---@param ts table
---@param buf number
---@param lang string
function M:install_and_enable(ts, buf, lang)
    if installing[buf] == lang then
        return
    end
    installing[buf] = lang

    ts.install(lang):await(function(err)
        if installing[buf] == lang then
            installing[buf] = nil
        end
        if err then
            vim.notify(err, vim.log.levels.ERROR)
            return
        end
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
            return
        end
        if vim.treesitter.language.get_lang(vim.bo[buf].filetype) ~= lang then
            return
        end
        vim.notify('Installed ' .. lang)
        self.enable(buf, lang)
    end)
end

M.config = function()
    local ts = require 'nvim-treesitter'
    ts.setup {}
    local ignored = {
        noice = true,
        lazy = true,
        mason = true,

        help = true,
        checkhealth = true,
        qf = true,

        TelescopePrompt = true,
        TelescopeResults = true,

        notify = true,

        cmd_docs = true,
        cmd_history = true,
        cmd_menu = true,

        ['neo-tree'] = true,
        aerial = true,
        trouble = true,

        alpha = true,
        dashboard = true,

        starter = true,
        snacks_dashboard = true,

        text = true,
        env = true,
        conf = true,
    }

    local ignored_buftypes = {
        nofile = true,
        prompt = true,
        quickfix = true,
        terminal = true,
    }

    local function enable_buffer(buf)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
            return
        end

        local ft = vim.bo[buf].filetype
        local bt = vim.bo[buf].buftype
        if ft == '' or ignored[ft] or ignored_buftypes[bt] then
            return
        end

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            vim.notify('No language parser found for ' .. ft)
            return
        end

        local could_load, err = vim.treesitter.language.add(lang)
        if could_load then
            return M.enable(buf, lang)
        end

        local parser_not_found_err = 'no parser for language "' .. lang .. '"'
        if err and err:lower() ~= parser_not_found_err then
            vim.notify('Error checking parser for ' .. ft .. ': ' .. err, vim.log.levels.ERROR)
            return
        end

        if not vim.tbl_contains(ts.get_available(), lang) then
            vim.notify('No language parser found for ' .. ft)
            return
        end

        return M:install_and_enable(ts, buf, lang)
    end

    local group = vim.api.nvim_create_augroup('my.treesitter', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        group = group,
        callback = function(args)
            enable_buffer(args.buf)
        end,
    })

    local function enable_loaded_buffers()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            enable_buffer(buf)
        end
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        group = group,
        callback = enable_loaded_buffers,
    })
    enable_loaded_buffers()
end

return M
