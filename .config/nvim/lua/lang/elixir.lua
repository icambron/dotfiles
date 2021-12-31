local nvim_lsp = require('lspconfig')

nvim_lsp.elixirls.setup {
	cmd = {'/home/isaac/.elixir-ls/language_server.sh'}
}

