local M = {}

function M.setup()
  local module_name = "which-key"
  local whichkey = require(module_name)

  local conf = {
    show_help = false,
    ignore_missing = true,
    plugins = {
      marks = false,
      registers = false,
      presets = {
        operators = false,
        motions = false,
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 0, 0, 0, 0 },
      padding = { 0, 1, 0, 1 },
      winblend = 0
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 1, max = 50 }, -- min and max width of the columns
      spacing = 10, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
  }

  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Startup screen" },
    ["-"] = { ":split<CR>", "Horizonal split" },
    ['|'] = { ":vsplit<CR>", "Vertical split" },
    [","] = { "<cmd>Telescope buffers<cr>", "List buffers" },
    ["<Space>"] = { "<cmd>Telescope find_files hidden=true layout_config={'prompt_position':'top'}<cr>", "Files" },

    b = {
      name = "Buffer",
      b = { "<cmd>Telescope buffers<cr>", "List buffers" },
      c = { "<Cmd>close<Cr>", "Close split" },
      k = { "<Cmd>lua require('bufdelete').bufdelete(0, true)<Cr>", "Kill current" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all" },
      n = { "<Cmd>bnext<Cr>", "Next buffer" },
      p = { "<Cmd>bprev<Cr>", "Previous buffer" },

    },

    f = {
      name = "File",
      -- a = { "<cmd>Telescope autocommands<cr>", "Autocommands" },
      -- c = { "<cmd>Telescope commands<cr>", "Commands" },
      --     d = { "<cmd>Telescope find_dotfiles<cr>", "Dotfiles" },
      --     e = { "<cmd>RnvimrToggle<CR>", "Ranger" },
      b = { "<cmd>lua require('telescope').extensions.file_browser.file_browser({ previewer = false, })<cr>",
        "File browser" },
      f = { "<cmd>Telescope find_files hidden=true layout_config={'prompt_position':'top'}<cr>", "Files" },
      -- g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      --      i = { "<cmd>Telescope highlights<cr>", "Highlights" },
      -- m = { "<cmd>Telescope marks<cr>", "Marks" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
      -- r = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>NvimTreeToggle<cr>", "Tree explorer" },
    },

    g = {
      name = "Git",
      b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Blame" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff view open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff view close" },
      g = { "<cmd>lua Toggle_lazygit()<cr>", "Lazygit open" }
    },

    c = {
      name = "Code",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      i = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP document symbols" },
      n = { "<cmd>lua vim.lsp.buf.rename()<Cr>", "LSP rename" },
      d = { "<cmd>Telescope lsp_definitions<Cr>", "LSP definitions" },
      r = { "<cmd>Telescope lsp_references<Cr>", "LSP references" },
      x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
      t = {
        name = "Test",
        a = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test all" },
        c = { "<cmd>lua require('neotest').run.attach()<cr>", "attach" },
        l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Test last" },
        o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
        S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
        s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
        t = { "<cmd>lua require('neotest').run.run()<cr>", "Test nearest" },
        w = { "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>", "Test workspace" },
      },
      D = {
        name = "Debug",
        b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
        d = { "<cmd>lua Start_debug()<Cr>", "Start debug" },
        t = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle dap ui" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
        o = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
        O = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
      },
    },


    p = {
      name = "Project",
      p = { "<cmd>Telescope projects<cr>", "Recent projects" },
    },


    z = {
      name = "System",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      h = { "<cmd>lua Toggle_htop()<cr>", "Htop" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      l = { "<cmd>PackerClean<cr>", "clean" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      q = { "<cmd>q!<CR>", "Quit" },
    },

    s = {
      name = "Search",
      i = { "<cmd>Telescope lsp_document_symbols<cr>", "Jump to Symbol" },
      b = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Search Buffer" },
      h = { "<cmd>Telescope help_tags<cr>", "Search Help" },
      k = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
      d = { "<cmd>Telescope diagnostics<Cr>", "Search Diagnostics" },
      p = { "<cmd>Telescope live_grep<cr>", "Search Project" },
    },


    w = {
      name = "Window",
      h = { "<C-w>h", "Move Left" },
      j = { "<C-w>j", "Move Down" },
      k = { "<C-w>k", "Move Up" },
      l = { "<C-w>l", "Move Right" },
      q = { "<C-w>q", "Close" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
