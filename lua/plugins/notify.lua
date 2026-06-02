local M = { 'rcarriga/nvim-notify' }

M.event = 'VeryLazy'

M.config = function()
    local n = require 'notify'
    local get_background_colour = function()
        local hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
        if not hl or not hl.bg then
            return '#020202'
        end

        return string.format('#%06x', hl.bg)
    end

    n.setup {
        merge_duplicates = true,
        background_colour = get_background_colour(),
        render = 'minimal', -- 'default' si quieres con título e ícono
        stages = 'fade', -- animación suave, 'static' si quieres sin animación
        timeout = 3000,
        max_width = 40,
        top_down = true, -- notificaciones desde abajo como las tenías
        level = vim.log.levels.INFO,
    }

    vim.notify = n
end

return M
