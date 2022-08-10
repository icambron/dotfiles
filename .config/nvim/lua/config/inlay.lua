local M = {}

function M.toggle_inlay_hints()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "rust" then
    require("rust-tools.inlay_hints").toggle_inlay_hints()
  elseif ft == "typescript" then
    require("nvim-lsp-ts-utils").toggle_inlay_hints()
  else
    print("No inlay hints for", ft)
  end
end

return M
