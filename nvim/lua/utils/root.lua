local M = {}

-- Common root markers for different project types
local root_markers = {
    "go.mod", -- Go
    "Cargo.toml", -- Rust
    "package.json", -- Node.js
    "pyproject.toml", -- Python (Poetry)
    "requirements.txt", -- Python
    "Gemfile", -- Ruby
    "composer.json", -- PHP
    ".git", -- Git repository
    ".gitignore",
    "Makefile",
    "README.md",
    ".project", -- Generic project marker
}

-- Find project root by looking for markers
function M.find_root(path)
    path = path or vim.fn.expand("%:p:h")

    for _, marker in ipairs(root_markers) do
        local found = vim.fn.findfile(marker, path .. ";")
        if found ~= "" then
            return vim.fn.fnamemodify(found, ":p:h")
        end

        local found_dir = vim.fn.finddir(marker, path .. ";")
        if found_dir ~= "" then
            return vim.fn.fnamemodify(found_dir, ":p:h:h")
        end
    end

    -- Fallback to current working directory
    return vim.fn.getcwd()
end

-- Get the root directory for the current buffer
function M.get()
    return M.find_root()
end

-- Get root using LSP if available, fallback to file-based detection
function M.get_lsp_root()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
        return clients[1].config.root_dir
    end
    return M.get()
end

return M
