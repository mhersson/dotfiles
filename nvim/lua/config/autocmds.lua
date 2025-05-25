-- Autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.go.tmpl" },
    command = "set ft=gotmpl",
})

-- MPLS

local debounce_timer = nil
local debounce_delay = 300 -- Delay in milliseconds

local function sendMessageToLSP()
    -- Clear the previous timer if it exists
    if debounce_timer then
        debounce_timer:stop()
    end

    -- Create a new timer
    debounce_timer = vim.loop.new_timer()
    debounce_timer:start(
        debounce_delay,
        0,
        vim.schedule_wrap(function()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients()

            for _, client in ipairs(clients) do
                if client.name == "mpls" then
                    client.request(
                        "mpls/editorDidChangeFocus",
                        { uri = vim.uri_from_bufnr(bufnr) },
                        function(err, result) end,
                        bufnr
                    )
                end
            end
        end)
    )
end

-- Create an autocommand group
local group = vim.api.nvim_create_augroup("MarkdownFocus", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    callback = sendMessageToLSP,
    group = group,
})
