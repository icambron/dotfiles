local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

function Toggle_inlay_hints()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "rust" then
    -- rust tools removed inlay hints for some reason
    -- require("rust-tools.inlay_hints").toggle_inlay_hints()
  elseif ft == "typescript" then
    require("nvim-lsp-ts-utils").toggle_inlay_hints()
  else
    print("No inlay hints for", ft)
  end
end

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins

    { import = "plugins" },
    {
      "folke/which-key.nvim",

      keys = {

        {
          "<leader>bd",
          "<cmd>bd<cr>",
          desc = "Close current buffer",
        },
        {
          "<leader>bD",
          "<cmd>bd!<cr>",
          desc = "Close current buffer for real",
        },
        {
          "<leader>sc",
          "<cmd>noh<cr>",
          "Clear search",
        },
        {
          "<leader>uh",
          function()
            Toggle_inlay_hints()
          end,
          "Toggle inlay hints",
        },
      },
    },

    { "digitaltoad/vim-pug" },

    {
      "folke/tokyonight.nvim",
      lazy = true,
      opts = { style = "night" },
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "jose-elias-alvarez/typescript.nvim",
        "simrat39/rust-tools.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
      },
      init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = { "gn", vim.diagnostic.goto_next }
        keys[#keys + 1] = { "gp", vim.diagnostic.goto_prev }
      end,
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
          typescript = true,
          rust = true,
          markdown = true,
          help = true,
        },
      },
    },

    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { "echasnovski/mini.pairs", enabled = false },

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
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
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
      keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
        {
          "<leader>F",
          function() require("telescope.builtin").find_files() end,
          desc = "Find Files (cwd)",
        },
        {
          "<leader>S",
          function()
            require("telescope.builtin").live_grep()
          end,
          desc = "Grep (cwd)",
        },
        {
          "<leader>bf",
          function()
            require("telescope.builtin").buffers()
          end,
          desc = "Grep (cwd)",
        },
      },
      options = {
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
