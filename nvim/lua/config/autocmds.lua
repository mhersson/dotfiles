-- Autocmds

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.go.tmpl" },
    command = "set ft=gotmpl",
})

-- Switch to normal mode after switching project
local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("User", {
    pattern = { "SessionLoadPost" },
    group = augroup,
    desc = "Switch to Normal Mode",
    callback = function()
        vim.cmd("stopinsert")
    end,
})

-- Stop LSP servers when they are not attached to any buffers
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        vim.schedule(function()
            local clients = vim.lsp.get_clients()
            for _, client in ipairs(clients) do
                local buffers = client.attached_buffers
                if vim.tbl_isempty(buffers) then
                    client:stop()
                end
            end
        end)
    end,
})

-- Tree-sitter
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype

        -- Only enable if a parser exists for this filetype
        if pcall(vim.treesitter.get_parser, bufnr, ft) then
            vim.treesitter.start(bufnr)
        end
    end,
})

-- Copilot
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

            vim.keymap.set(
                "i",
                "<M-Tab>",
                vim.lsp.inline_completion.get,
                { desc = "LSP: accept inline completion", buffer = bufnr }
            )
            vim.keymap.set(
                "i",
                "<C-G>",
                vim.lsp.inline_completion.select,
                { desc = "LSP: switch inline completion", buffer = bufnr }
            )
        end
    end,
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

        timer = vim.uv.new_timer()
        if not timer then
            return
        end

        timer:start(
            delay,
            0,
            vim.schedule_wrap(function()
                if timer then
                    timer:close()
                    timer = nil
                end

                local bufnr = vim.api.nvim_get_current_buf()
                if vim.bo[bufnr].filetype ~= "markdown" then
                    return
                end

                local clients = vim.lsp.get_clients({ name = "mpls", bufnr = bufnr })
                if #clients == 0 then
                    return
                end

                clients[1]:notify("mpls/editorDidChangeFocus", {
                    uri = vim.uri_from_bufnr(bufnr),
                })
            end)
        )
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    callback = create_debounced_mpls_sender(300),
    group = vim.api.nvim_create_augroup("MplsFocus", { clear = true }),
    desc = "Notify MPLS of buffer focus changes",
})
