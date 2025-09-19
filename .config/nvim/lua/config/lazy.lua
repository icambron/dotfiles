local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

    { import = "plugins" },

    {
      "folke/noice.nvim",
      opts = {
        routes = {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "E486" },
                { find = "search hit BOTTOM" },
                { find = "change;" },
                { find = "line less;" },
                { find = "fewer lines;" },
                { find = "more lines;" },
                { find = "more line;" },
              },
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "Already at oldest change" },
                { find = "overly long loop run" },
              },
            },
            view = "mini",
          },
        },
      },
    },

    { "nvim.mini/mini.pairs", enabled = false },
    { "folke/flash.nvim", opts = { modes = { search = { enabled = false } } } },
    { "Pocco81/true-zen.nvim" },
    { "digitaltoad/vim-pug" },

    {
      "nvim-mini/mini.bufremove",
      -- stylua: ignore
      keys = {
        { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
        { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
      },
    },

    {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
      keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
      config = function(_, opts)
        require("symbols-outline").setup(opts)
      end,
      opts = {
        symbols = {
          Namespace = { icon = "", hl = "@namespace" },
          Array = { icon = "", hl = "@constant" },
          File = { icon = "", hl = "@text.uri" },
          Module = { icon = "", hl = "@namespace" },
          Package = { icon = "", hl = "@namespace" },
          Field = { icon = "", hl = "@field" },
          Interface = { icon = "", hl = "@type" },
          Object = { icon = "⦿", hl = "@type" },
          Key = { icon = "", hl = "@type" },
          Null = { icon = "󰟢", hl = "@type" },
          Event = { icon = "", hl = "@type" },
          Component = { icon = "", hl = "@function" },
          Fragment = { icon = "", hl = "@constant" },
        },
      },
    },

    {
      "folke/tokyonight.nvim",
      lazy = true,
      opts = {
        style = "night",
        on_colors = function(colors)
          colors.bg = "#08090c"
        end,
      },
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        "simrat39/rust-tools.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
      },
      opts = {
        tools = {
          autoSetHints = true,
          inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          },
        },
        -- make sure mason installs the server
        servers = {
          ---@type lspconfig.options.tsserver
          tsserver = {
            settings = {
              typescript = {
                format = {
                  indentSize = vim.o.shiftwidth,
                  convertTabsToSpaces = vim.o.expandtab,
                  tabSize = vim.o.tabstop,
                },
              },
              javascript = {
                format = {
                  indentSize = vim.o.shiftwidth,
                  convertTabsToSpaces = vim.o.expandtab,
                  tabSize = vim.o.tabstop,
                },
              },
              completions = {
                completeFunctionCalls = true,
              },
            },
          },
          rust_analyzer = {
            mason = false,
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                checkOnSave = {
                  command = "clippy",
                },
                procMacro = {
                  enable = true,
                },
                diagnostics = {
                  disabled = {
                    "unresolved-proc-macro",
                  },
                },
              },
            },
          },
        },
        setup = {
          rust_analyzer = function(_, opts)
            require("rust-tools").setup({ server = opts })
            return true
          end,
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tsserver" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      opts = {
        suggestion = { enabled = true },
        panel = { enabled = true },
        filetypes = {
          javascript = true,
          typescript = true,
          rust = true,
          markdown = true,
          help = true,
        },
      },
    },

    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require("cmp")
        opts.mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Add tab support
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          -- ["<C-k>"] = cmp.mapping.select_prev_item(),
          -- ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),
          ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        }
      end,
    },

    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      opts = {
        pickers = {
          buffers = {
            sort_lastused = true,
          },
          find_files = {
            hidden = true,
          },
        },
      },
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- todo:
-- 1. <leader>sc to clear search (need to unbind existing behavior)
-- 2. <leader>l to show last search, move upgrade to <leader>L and unbind existing <leader>L (changelog)
-- 3. remove <alt>k and <alt>j from moving lines - they're too easy to accidentally chord with <esc>. find some nice alternative
