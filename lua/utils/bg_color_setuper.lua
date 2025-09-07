---@param disable_bg_color boolean
---@param disable_float_bg_color boolean
local function bg_setuper(disable_bg_color, disable_float_bg_color)
    if disable_bg_color then vim.cmd [[hi Normal guibg=NONE]] end
    if disable_float_bg_color then
        vim.cmd [[
            hi FloatBorder guibg=NONE
            hi NormalFloat guibg=NONE
        ]]
    end
    return nil
end

Bg_transparent = false

local function toggle_bg()
    Bg_transparent = not Bg_transparent
    bg_setuper(Bg_transparent, Bg_transparent)
end

local M = {}
M.bg_setuper = bg_setuper
M.toggle_bg = toggle_bg
M.Bg_transparent = Bg_transparent

return M
