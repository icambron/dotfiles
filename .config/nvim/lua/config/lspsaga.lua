local saga = require("lspsaga")

local config = {
  code_action_keys = {
    quit = "<Esc>"
  },
  finder_action_keys = {
    open = "<Enter>",
    quit = "<Esc>"
  }
}

saga.init_lsp_saga(config)
