local lspconfig = require("lspconfig")
local ts_utils = require("nvim-lsp-ts-utils")
lspconfig.tsserver.setup({
  init_options = ts_utils.init_options,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    ts_utils.setup({
        eslint_bin = "eslint_d",
        eslint_enable_diagnostics = true,
        eslint_enable_code_actions = true,
        enable_formatting = true,
        formatter = "prettier"
    })
    ts_utils.setup_client(client)
  end
})
