local nvim_lsp = require('lspconfig')

nvim_lsp.elixirls.setup {
	cmd = {'/opt/elixir-ls/language_server.sh'}
}

nvim_lsp.tsserver.setup{}

