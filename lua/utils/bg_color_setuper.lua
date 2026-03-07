-- =========================
-- Utils
-- =========================

local M = {}

M.state = {
    bg_transparent = false,
    float_transparent = false,
}

M.cache = {
    normal = nil,
    normalfloat = nil,
    floatborder = nil,
}

M.set_hl = function(name, hl) vim.api.nvim_set_hl(0, name, hl) end
M.get_hl = function(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) end

M.float_border = 'rounded'

-- =========================
-- Background handling
-- =========================

---@param disable_bg boolean
---@param disable_float_bg boolean
function M:bg_setuper(disable_bg, disable_float_bg)
    if self.cache.Normal == nil then self.cache.Normal = self.get_hl 'Normal' end
    if self.cache.FloatBorder == nil then
        self.cache.NormalFloat = self.get_hl 'NormalFloat'
        self.cache.FloatBorder = self.get_hl 'FloatBorder'
    end

    M.state.bg_transparent = not disable_bg
    M.state.float_transparent = not disable_float_bg

    -- Normal
    if disable_bg then
        self.set_hl('Normal', { bg = 'NONE' })
    else
        self.set_hl('Normal', M.cache.Normal)
    end

    -- Floating
    if disable_float_bg then
        self.set_hl('NormalFloat', { bg = 'NONE' })
        self.set_hl(
            'FloatBorder',
            vim.tbl_extend('force', M.cache.FloatBorder or {}, {
                bg = 'NONE',
            })
        )
    else
        self.set_hl('NormalFloat', M.cache.NormalFloat)
        self.set_hl('FloatBorder', M.cache.FloatBorder)
    end
end

function M:clear_cache() self.cache = { normal = nil, normalfloat = nil, floatborder = nil } end

function M:toggle_bg()
    local is_bg_transparent = not self.state.bg_transparent
    self:bg_setuper(is_bg_transparent, false)

    self.state.bg_transparent = is_bg_transparent
    vim.notify(string.format('bg: %s', is_bg_transparent and 'transparent' or 'opaque'), vim.log.levels.INFO)
end

return M
