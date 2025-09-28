-- Basic settings
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_us"
vim.opt.title = true
vim.opt.titlestring = "nvim"

-- Leader (this is here so plugins etc pick it up)
vim.g.mapleader = " "

-- use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Display settings
vim.opt.termguicolors = true

-- Scrolling and UI settings
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

-- Persist undo (persists your undo history between sessions)
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- Tab stuff
vim.opt.expandtab = true
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.autoindent = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- open new split panes to right and below (as you probably expect)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- LSP
vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({ virtual_text = true })

-- bootstrapping for plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- plugins
require("lazy").setup({
  -- util
  { "nvim-lua/plenary.nvim" },

  -- theme
  {
      "folke/tokyonight.nvim",
      opts = {
        style = "night",
        on_colors = function(colors)
          colors.bg = "#08090c"
        end
      }
  },

  -- status line
  { "nvim-lualine/lualine.nvim" },

  -- syntax
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "typescript", "python", "rust", "javascript" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, },
      })
    end
  },

  -- LSP
  {
    { 'mason-org/mason.nvim', opts = {} },
    {
      'mason-org/mason-lspconfig.nvim',
      dependencies = { 'neovim/nvim-lspconfig' },
      opts = {
      }
    },
  },

  -- niceties
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  },

   -- completion
  -- {'saghen/blink.cmp',
  -- opts = {
  --   completion = {
  --     documentation = { auto_show = true }
  --   },
  -- },
  -- version = "1.*",
  -- opt_extend = { "sources_defualt" }},

  -- keyboard completion guide
  {
    "folke/which-key.nvim",
    event = "VeryLazy"
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot", "lsp" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
            opts = {
              max_completions = 3
            }
          },
        },
      },
    },
    version = "1.*",
    opt_extend = { "sources_default" },
  }
})

-- initialize plugins
vim.cmd.colorscheme("tokyonight")
require("lualine").setup()      -- the status line

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "ruff", "rust_analyzer" } })

require("which-key").add({
  { "<leader>?", function() require("which-key").show({ glogal = false }) end, desc = "Key help" },
  { "<leader>F", function() require("snacks").picker.smart() end, desc = "Find files" },
  { "<leader>S", function() require("snacks").picker.smart() end, desc = "Search" },
  { "<leader>s", function() require("snacks").picker.lsp_symbols() end, desc = "LSP Symbols" },
  { "<leader>Z", function() require("snacks").zen.zoom() end, desc = "Toggle Zoom" },
  { "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },
  { "<leader>d", function() require("snacks").picker.diagnostics() end, desc = "Diagnostics" },
  { "<leader>D", function() require("snacks").picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
  { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Go to Definition" },
  { "gr", function() require("snacks").picker.lsp_references() end, nowait = true, desc = "References" },
  { "gt", function() require("snacks").picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
  { "sc", "<cmd>lua require('snacks').picker.smart()<cr>", desc = "Clear search" }
})

