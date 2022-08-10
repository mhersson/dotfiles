-- Automatically install packerplugin
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  }

  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

vim.api.nvim_create_augroup("_packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "_packer_user_config",
  pattern = "*/plugins/init.lua",
  callback = function()
    vim.cmd("source <afile>")
    vim.cmd("PackerSync")
  end
})

-- Have packer use a popup window
packer.init {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "single"
  },
  max_jobs = 50,
  git = { clone_timeout = 600, },
  auto_clean = true,
  ensure_dependencies = true,
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------------------------
  -- Look & Feel
  -----------------------------------------------------------------------------
  use({
    "olimorris/onedarkpro.nvim",
    config = function()
      require("plugins.config.theme")
    end
  })

  use { 'feline-nvim/feline.nvim',
    requires = { "kyazdani42/nvim-web-devicons",
      "lewis6991/gitsigns.nvim" },
    config = function()
      require("plugins.config.feline")
    end
  }

  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugins.config.alpha") end,
    event = "VimEnter",
  }

  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    after = { "nvim-web-devicons", "onedarkpro.nvim" },
    config = function() require("plugins.config.bufferline") end,
    event = "VimEnter",
  }

  -----------------------------------------------------------------------------
  -- Navigation
  -----------------------------------------------------------------------------
  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugins.config.nvim_tree") end,
    event = "BufEnter",
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.config.project").setup()
    end,
  } -- Project management (Telescope projects)

  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function() require("plugins.config.whichkey").setup() end,
  }

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------
  use {
    "williamboman/nvim-lsp-installer",
    requires = { "neovim/nvim-lspconfig", "mfussenegger/nvim-lint" },
  }

  use {
    "j-hui/fidget.nvim",
    config = function() require("plugins.config.fidget") end,
    event = "BufReadPre",
  } -- LSP progress indicator

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("plugins.config.trouble") end,
    event = "BufEnter",
  }

  use "folke/lsp-colors.nvim" -- Add missing LSP highlight groups
  use "nvim-lua/lsp-status.nvim" -- Used by other plugins for basic lsp info

  -----------------------------------------------------------------------------
  -- Completions
  -----------------------------------------------------------------------------
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", -- Buffer completions
      "hrsh7th/cmp-path", -- Path completions
      "hrsh7th/cmp-cmdline", -- Cmdline completions
      "hrsh7th/cmp-nvim-lua", -- API completions
      "hrsh7th/cmp-nvim-lsp", -- LSP completions
      "hrsh7th/cmp-nvim-lsp-document-symbol", -- For textDocument/documentSymbol

      -- Snippets
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "L3MON4D3/LuaSnip", --snippet engine
      "rafamadriz/friendly-snippets", -- a bunch of snippets to use

      -- Misc
      "lukas-reineke/cmp-under-comparator", -- Tweak completion order
      "f3fora/cmp-spell",
    },
    config = function() require("plugins.config.cmp") end,
    --event = "BufEnter",
  }

  -----------------------------------------------------------------------------
  -- Treesitter
  -----------------------------------------------------------------------------
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "p00f/nvim-ts-rainbow",
      -- "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    run = ":TSUpdate",
    config = function() require("plugins.config.treesitter") end,
    -- event = "BufReadPre",
  }
  -----------------------------------------------------------------------------
  -- Telescope
  -----------------------------------------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function() require("plugins.config.telescope") end,
    event = "BufEnter",
  }

  -----------------------------------------------------------------------------
  -- Syntax, Languages & Code
  -----------------------------------------------------------------------------
  use "ekalinin/Dockerfile.vim"
  use "cespare/vim-toml"
  use "tpope/vim-rails"
  use "vim-ruby/vim-ruby"
  use "mtdl9/vim-log-highlighting"

  use {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    requires = { "nvim-treesitter/nvim-treesitter" }
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "olimorris/neotest-rspec",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    config = function() require("plugins.config.neotest") end,
    event = "BufEnter",
  }

  use "folke/lua-dev.nvim"

  -----------------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------------
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require('gitsigns').setup() end,
    event = "BufReadPre",
  }

  use { 'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("plugins.config.neogit") end,
  }

  use {
    "sindrets/diffview.nvim",
    config = function() require("plugins.config.diffview") end,
    requires = "nvim-lua/plenary.nvim",
    cmd = "DiffviewOpen",
  }

  -----------------------------------------------------------------------------
  -- Misc
  -----------------------------------------------------------------------------
  -- Wrap text
  use {
    "tpope/vim-surround",
    requires = { "tpope/vim-repeat" },
    event = "BufEnter",
  }

  -- Delete buffers but maintain layout
  use {
    "famiu/bufdelete.nvim",
    event = "BufEnter",
  }

  -- Pretty notifications
  use {
    "rcarriga/nvim-notify",
    config = function() require("plugins.config.notify") end,
    event = "BufEnter",
  }

  -- Comment lines/blocks
  use {
    'numToStr/Comment.nvim',
    config = function() require("plugins.config.comment") end,
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufEnter",
  }

  -- Terminal
  use { "akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
    require("plugins.config.toggleterm")
  end,
  }

  -- Profiling and Performance
  use "dstein64/vim-startuptime"
  use "lewis6991/impatient.nvim"

  -----------------------------------------------------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -----------------------------------------------------------------------------
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
