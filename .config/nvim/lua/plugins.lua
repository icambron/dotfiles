local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

local packer_bootstrap
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

  -- shade is great but blows up when I use floating windows
  -- use { "sunjon/Shade.nvim", config = [[require("config.shade")]] }

  -- editor plugins
  use "tpope/vim-repeat"

  use "lukas-reineke/indent-blankline.nvim"

  use {
    "folke/which-key.nvim",
    config = [[require("config.keys")]]
  }

  use "ggandor/lightspeed.nvim"

  -- outlining
  use {'simrat39/symbols-outline.nvim'}

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    require = {
      { "p00f/nvim-ts-rainbow", after = "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "rust", "lua", "typescript" },

        -- see https://github.com/nvim-treesitter/nvim-treesitter/issues/1957
        ignore_install = { "elixir", "php" },
        highlight = {
          enable = true
        },
        rainbow = {
          enable = false -- for now
        }
      }
    end
  }

  use { 'sbdchd/neoformat' }
	--use "lukas-reineke/lsp-format.nvim"

  -- other language plugins
  -- use "cespare/vim-toml", { "branch": "main" }
  use 'terminalnode/sway-vim-syntax'
  use "jose-elias-alvarez/null-ls.nvim"

  -- until perf issues with elixir treesitter are fixed
  use "elixir-editors/vim-elixir"

  use {
    "simrat39/rust-tools.nvim",
    requires = { "neovim/nvim-lspconfig" },
    config = [[require("lang.rust")]]
  }

  -- lsp stuff
  use { "jose-elias-alvarez/nvim-lsp-ts-utils"}
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/nvim-cmp",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "stevearc/aerial.nvim"
    },
    config = [[require("config.lsp")]]
  }

  use {
    "tami5/lspsaga.nvim",
    config = [[require("config.lspsaga")]]
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

	use {'nvim-telescope/telescope-ui-select.nvim' }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-lua/telescope.nvim"
    },
    cmd = "Telescope",
    config = [[require("config.telescope")]]
  }

  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- debugger
  use "mfussenegger/nvim-dap"

  use {
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_transparent = true
      vim.gtokyonight_colors = {
        background = "#08090c"
      },
      vim.cmd("colorscheme tokyonight")
    end
  }

  use {
   "nvim-lualine/lualine.nvim",
   requires = "folke/tokyonight.nvim",
   config = function()
    require("lualine").setup {
      options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = { {"filename", path = 1 } },
        lualine_x = {"encoding", "fileformat", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"}
      }
    }
  end
 }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
