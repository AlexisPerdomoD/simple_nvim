-- Crear una función global para el corrector ortográfico personalizado
return function()
    -- Obtener la palabra bajo el cursor
    local word = vim.fn.expand("<cword>")

    -- Obtener sugerencias para la palabra
    local suggestions = vim.fn.spellsuggest(word, 10)
    if #suggestions == 0 then
        print("No hay sugerencias para: " .. word)
        return
    end

    -- Crear un buffer temporal para mostrar las sugerencias
    local buf = vim.api.nvim_create_buf(false, true)

    -- Preparar las líneas para el buffer
    local lines = { "Sugerencias para: " .. word, "" }
    for i, suggestion in ipairs(suggestions) do
        table.insert(lines, i .. ": " .. suggestion)
    end
    table.insert(lines, "")
    table.insert(lines, "Presiona el número para seleccionar o <Esc> para cancelar")

    -- Llenar el buffer con las líneas
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")

    -- Dimensiones de la ventana
    local width = 60
    local height = math.min(#lines + 2, 15)

    -- Crear ventana flotante
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "cursor",
        row = 1,
        col = 0,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded"
    })

    -- Función para aplicar una corrección
    _G.apply_correction = function(index)
        if index > 0 and index <= #suggestions then
            local correction = suggestions[index]
            -- Cerrar ventana y buffer antes de aplicar la corrección
            pcall(vim.api.nvim_win_close, win, true)
            pcall(vim.api.nvim_buf_delete, buf, { force = true })
            -- Aplicar la corrección
            vim.cmd("normal! ciw" .. correction)
        end
    end

    -- Función para cerrar la ventana
    _G.close_spell_window = function()
        pcall(vim.api.nvim_win_close, win, true)
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end

    -- Configurar mapeos para selección
    for i = 1, 9 do
        if i <= #suggestions then
            vim.api.nvim_buf_set_keymap(buf, "n", tostring(i),
                string.format(":lua _G.apply_correction(%d)<CR>", i),
                { noremap = true, silent = true })
        end
    end

    vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":lua _G.close_spell_window()<CR>",
        { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":lua _G.close_spell_window()<CR>",
        { noremap = true, silent = true })
end
