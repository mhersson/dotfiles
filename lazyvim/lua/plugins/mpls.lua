return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        mpls = {},
      },
      setup = {
        mpls = function(_, opts)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")

          local debounce_timer = nil
          local debounce_delay = 300  -- Delay in milliseconds

          local function sendMessageToLSP()
              -- Clear the previous timer if it exists
              if debounce_timer then
                  debounce_timer:stop()
              end

              -- Create a new timer
              debounce_timer = vim.loop.new_timer()
              debounce_timer:start(debounce_delay, 0, vim.schedule_wrap(function()
                  local bufnr = vim.api.nvim_get_current_buf()
                  local clients = vim.lsp.get_active_clients()

                  for _, client in ipairs(clients) do
                      if client.name == "mpls" then
                          client.request('mpls/editorDidChangeFocus', { uri = vim.uri_from_bufnr(bufnr) }, function(err, result)
                          end, bufnr)
                      end
                  end
              end))
          end

          -- Create an autocommand group
          local group = vim.api.nvim_create_augroup("MarkdownFocus", { clear = true })
          vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*.md",
            callback = sendMessageToLSP,
            group = group,
          })

          if not configs.mpls then
            configs.mpls = {
              default_config = {
                cmd = { "mpls", "--no-auto", "--enable-emoji" },
                filetypes = { "markdown" },
                single_file_support = true,
                root_dir = function(startpath)
                  local git_root = vim.fs.find(".git", { path = startpath or vim.fn.getcwd(), upward = true })
                  return git_root[1] and vim.fs.dirname(git_root[1]) or startpath
                end,
                settings = {},
              },
              docs = {
                description = [[https://github.com/mhersson/mpls

Markdown Preview Language Server (MPLS) is a language server that provides
live preview of markdown files in your browser while you edit them in your favorite editor.
                ]],
              },
            }
          end
          lspconfig.mpls.setup(opts)
          vim.api.nvim_create_user_command('MplsOpenPreview', function()
            local clients = vim.lsp.get_active_clients()
            local mpls_client = nil

            for _, client in ipairs(clients) do
              if client.name == "mpls" then
                mpls_client = client
                break
              end
            end

            -- Only execute the command if the MPLS client is found
            if mpls_client then
              local params = {
                command = 'open-preview',
                arguments = {}
              }
              mpls_client.request('workspace/executeCommand', params, function(err, result)
                if err then
                  print("Error executing command: " .. err.message)
                end
              end)
            else
              print("mpls is not attached to the current buffer.")
            end
          end, {})
        end,
      },
    },
  },
}
