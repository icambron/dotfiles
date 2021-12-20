local aerial = require("aerial")

require("lspconfig").vimls.setup {
  on_attach = aerial.on_attach
}

require("lang.ts")
require("lang.lua")
require("lang.elixir")
