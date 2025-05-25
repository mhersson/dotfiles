-- Autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.go.tmpl" },
    command = "set ft=gotmpl",
})

-- MPLS Focus Handler

local function create_debounced_mpls_sender(delay)
    delay = delay or 300
    local timer = nil

    return function()
        if timer then
            timer:close()
            timer = nil
        end

        ---@diagnostic disable-next-line: undefined-field
        timer = vim.uv.new_timer()
        if not timer then
            vim.notify("Failed to create timer for MPLS focus", vim.log.levels.ERROR)
            return
        end

        timer:start(
            delay,
            0,
            vim.schedule_wrap(function()
                local bufnr = vim.api.nvim_get_current_buf()

                local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                if filetype ~= "markdown" then
                    return
                end

                local clients = vim.lsp.get_clients({ name = "mpls" })

                if #clients == 0 then
                    return
                end

                local client = clients[1]
                local params = { uri = vim.uri_from_bufnr(bufnr) }

                ---@diagnostic disable-next-line: param-type-mismatch
                client.notify("mpls/editorDidChangeFocus", params)

                if timer then
                    timer:close()
                    timer = nil
                end
            end)
        )
    end
end

local send_mpls_focus = create_debounced_mpls_sender(300)

local group = vim.api.nvim_create_augroup("MplsFocus", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    callback = send_mpls_focus,
    group = group,
    desc = "Notify MPLS of buffer focus changes",
})
