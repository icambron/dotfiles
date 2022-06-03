local lspconfig = require("lspconfig")
local ts_utils = require("nvim-lsp-ts-utils")
lspconfig.tsserver.setup({
  init_options = ts_utils.init_options,
  on_attach = function(client)
    ts_utils.setup({
        auto_inlay_hints = false,
				-- filter_out_diagnostics_by_severity = { "hint" },
        eslint_enable_diagnostics = true,
        eslint_enable_code_actions = true,
    })
    ts_utils.setup_client(client)
  end
})

vim.api.nvim_command("autocmd FileType typescript setlocal tabstop=4")
vim.api.nvim_command("autocmd FileType typescript.tsx setlocal tabstop=4")
vim.api.nvim_command("autocmd FileType typescriptreact setlocal tabstop=4")
vim.api.nvim_command("autocmd FileType typescript setlocal shiftwidth=4")
vim.api.nvim_command("autocmd FileType typescript.tsx setlocal shiftwidth=4")
vim.api.nvim_command("autocmd FileType typescriptreact setlocal shiftwidth=4")
