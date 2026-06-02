local MAX_FILESIZE = 1024 * 1024 -- 1MB

---@param filename string Filename to check for size (full path)
---@return boolean Whether the file is too large or not
local function is_too_large(filename)
    local ok, stats = pcall(vim.loop.fs_stat, filename)

    if not ok or not stats then
        return false
    end

    if stats.size <= MAX_FILESIZE then
        return false
    end

    -- vim.b[args.buf].large_file = true
    return true
end

return {
    is_too_large = is_too_large,
    MAX_FILESIZE = MAX_FILESIZE,
}
