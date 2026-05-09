local M = { 'nvim-treesitter/nvim-treesitter' }
M.event = 'BufReadPost'
M.build = ':TSUpdate'

---@param buf number
---@param lang string
M.enable = function(buf, lang)
    local could_exec = pcall(vim.treesitter.start, buf, lang)
    if not could_exec then
        vim.notify('Failed to start ' .. lang, vim.log.levels.ERROR)
        return
    end
    vim.wo[0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0].foldmethod = 'expr'
end

---@param ts table
---@param buf number
---@param lang string
function M:install_and_enable(ts, buf, lang)
    ts.install(lang):await(function(err)
        if err then
            vim.notify(err, vim.log.levels.ERROR)
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
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function(args)
            local ft = vim.bo[args.buf].filetype
            local bt = vim.bo[args.buf].buftype
            if ignored[ft] or ignored_buftypes[bt] then
                return
            end

            local lang = vim.treesitter.language.get_lang(ft)
            if not lang then
                vim.notify('No language parser found for ' .. ft)
                return
            end

            local could_load, err = vim.treesitter.language.add(lang)
            if could_load then
                return M.enable(args.buf, lang)
            end

            local parser_nor_found_err = 'no parser for language "' .. lang .. '"'
            if err and err:lower() ~= parser_nor_found_err then
                vim.notify('Error checking parser for ' .. ft .. ': ' .. err, vim.log.levels.ERROR)
                return
            end

            if not vim.tbl_contains(ts.get_available(), lang) then
                vim.notify('No language parser found for ' .. ft)
                return
            end

            return M:install_and_enable(ts, args.buf, lang)
        end,
    })
end

return M
