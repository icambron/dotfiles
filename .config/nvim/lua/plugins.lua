local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

local packer = require("packer");
packer.reset()

packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- file tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('nvim-tree').setup {
      git = {
        ignore = true
      }
    } end
  }

  use "kyazdani42/nvim-web-devicons"

  -- editor plugins
  use "tpope/vim-repeat"

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "folke/which-key.nvim",
    config = [[require("config.keys")]]
  }

  use "ggandor/lightspeed.nvim"

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    require = {
      { "p00f/nvim-ts-rainbow", after = "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true
        },
        rainbow = {
          enable = false -- for now
        }
      }
    end
  }

  -- other language plugins
  -- use "elixir-editors/vim-elixir"
  -- use "cespare/vim-toml", { "branch": "main" }
  use 'terminalnode/sway-vim-syntax'
  use "jose-elias-alvarez/null-ls.nvim"

  use { "jose-elias-alvarez/nvim-lsp-ts-utils", config = [[require("config.ts")]] }

  use {
    "simrat39/rust-tools.nvim",
    requires = { "neovim/nvim-lspconfig" },
    config = [[require("config.rust")]]
  }

  -- lsp stuff
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/nvim-cmp",
    },
    config = [[require("config.lsp")]]
  }

  use {
    "tami5/lspsaga.nvim",
    branch = "nvim51",
    config = [[require("lspsaga").init_lsp_saga()]]
  }

  -- completion plugins
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/vim-vsnip"},
      { "hrsh7th/cmp-vsnip", after = {"nvim-cmp", "vim-vsnip" } },
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig"
    },
    ensure_dependencies = true,
    config = [[require("config.cmp")]]
  }

  use {
    "folke/trouble.nvim",
    config = [[require("trouble").setup()]]
  }

  -- fuzzy finder plugins
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-lua/telescope.nvim"
    },
    cmd = 'Telescope',
    config = [[require("config.telescope")]]
  }

  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- debugger
  use "mfussenegger/nvim-dap"

  -- theme
--  use {
--    "EdenEast/nightfox.nvim",
--    config = function()
--      local nightfox = require("nightfox")
--      nightfox.setup {
--        fox = "duskfox"
--      }
--       nightfox.load()
--    end
--  }

  use {
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_transparent = true
      vim.gtokyonight_colors = {
        background = '#08090c'
      },
      vim.cmd([[colorscheme tokyonight]])
    end
    -- config = [[require("config.tokyonight")]]
  }

  use {
   "nvim-lualine/lualine.nvim",
   requires = "folke/tokyonight.nvim",
   config = function()
    require("lualine").setup {
      options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" }
      }
    }
  end
 }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
