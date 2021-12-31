local nvim_lsp = require('lspconfig')

nvim_lsp.elixirls.setup {
	cmd = {'elixir-ls'}
}

