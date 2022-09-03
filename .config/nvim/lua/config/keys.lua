local function nmap(lhs, rhs)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local function vmap(lhs, rhs)
  vim.api.nvim_set_keymap("v", lhs, rhs, { noremap = true, silent = true })
end

nmap("K", "<cmd>Lspsaga hover_doc<cr>")
nmap(",", "<cmd>Lspsaga preview_definition<cr>")
nmap(";", "<cmd>Lspsaga code_action<cr>")
nmap("\\", "<cmd>Lspsaga lsp_finder<cr>")
nmap("gn", "<cmd>Lspsaga diagnostic_jump_next<cr>")
nmap("gp", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
nmap("gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
nmap("gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>")
nmap("gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>")

vim.g.mapleader = " "

local wk = require("which-key")
wk.setup()

local leader = {
  p = {
    name = "+project",
    f = {"<cmd>Telescope find_files<cr>", "find files"},
    g = {"<cmd>Telescope git_files<cr>", "git files"},
  },
  b = {
    name = "+buffers",
    b = { "<cmd>Telescope buffers<cr>", "list" },
    c = { "<cmd>bd<cr>", "close current" },
    C = { "<cmd>bd!<cr>", "close current" }
  },
  g = {
    name = "+git",
    c = { [[<cmd>lua require("telescope.builtin").git_commits()<cr>]], "commits"},
    b = { [[<cmd>lua require("telescope.builtin").git_branches()<cr>]], "branches"},
    s = { [[<cmd>lua require("telescope.builtin").git_status()<cr>]], "status"},
    t = { [[<cmd>lua require("telescope.builtin").git_stash()<cr>]], "stash"},
    f = { [[<cmd>lua require("telescope.builtin").git_bcommits()<cr>]], "file commits"},
  },
  c = {
    name = "+code",
    r = { [[<cmd>lua require("telescope.builtin").lsp_references()<cr>]], "references" },
		a = { [[<cmd>lua require('lspsaga.codeaction').code_action()<cr>]], "actions"},
    -- a = { [[<cmd>lua vim.lsp.buf.code_action()<cr>]], "actions" },
    s = { [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>]], "document symbols" },
		-- this is redundant with trouble
		d = { [[<cmd>lua require("telescope.builtin").diagnostics()<cr>]], "document symbols" },
  },
  r = {
    name = "+refactor",
    r = { "<cmd>Lspsaga rename<cr>", "rename" },
    f = { "<cmd>Neoformat<cr>", "format" }
  },
  t = {
    name = "+toggle",
    f = { "<cmd>NvimTreeToggle<cr>", "tree" },
    n = { "<cmd>set number!<cr>", "line numbers" },
    h = { [[<cmd>lua require("config.inlay").toggle_inlay_hints()<cr>]], "inlay hints" },
    s = { [[<cmd>lua require("shade").toggle()<cr>]], "shade" },
    o = { "<cmd>SymbolsOutline<cr>", "outline"}
  },
  v = {
    name = "+vim",
    r = { [[<cmd>lua require("telescope.builtin").registers()<cr>]], "registers" },
    m = { [[<cmd>lua require("telescope.builtin").marks()<cr>]], "marks" },
    j = { [[<cmd>lua require("telescope.builtin").jumplist()<cr>]], "jumplist" },
    c = { [[<cmd>lua require("telescope.builtin").commands()<cr>]], "commands" },
    h = { [[<cmd>lua require("telescope.builtin").commands_history()cr>]], "commands history" },
    s = { [[<cmd>lua require("telescope.builtin").search_history()<cr>]], "search history" },
    k = { [[<cmd>lua require("telescope.builtin").keymaps()<cr>]], "keymaps" },
    p = {[[<cmd>lua require("telescope.builtin").pickers()<cr>]], "pickers"},
  },
  m = {
    name = "+mgmt",
    r = {"<cmd>luafile %<cr>", "reload config"},
    u = {"<cmd>PackerSync<cr>", "packer sync"},
    c = { "<cmd>PackerCompile<cr>", "packer compile" },
  },
  s = {
		name = "+search",
    p = {"<cmd>Telescope live_grep<cr>", "search project"},
    c = {"<cmd>noh<cr>", "clear search"},
    l = {[[<cmd>lua require("telescope.builtin").resume()<cr>]], "previous"},
  },
  x = {
		name = "+trouble",
    t = {"<cmd>TroubleToggle<cr>", "toggle trouble"},
    w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace trouble"},
    d = {"<cmd>TroubleToggle document_diagnostics<cr>", "document trouble"},
    r = {"<cmd>TroubleRefresh<cr>", "refresh trouble"},
  },
	o = {
		name = "+rust",
		-- most of these should be folded into generic facilities, like with
		-- toggling inlay hints. However, that's silly until I have at least one other envthat can do it
		-- In fact, many of these should just get folded into standard LSP tooling
		r = {"<cmd>RustRunnables<cr>", "runnables" },
		m = {"<cmd>RustExpandMacro<cr>", "cargo" },
		c = {"<cmd>RustOpenCargo<cr>", "cargo" },
		p = {"<cmd>RustParentModule<cr>", "parent module" },
		-- should I just make J do this?
		j = {"<cmd>RustJoinLines<cr>", "join lines" },
		-- are these any different than LSP code actions?
		a = { "<cmd>RustHoverActions<cr>", "actions" },
		h = { "<cmd>RustHoverRange<cr>", "range actions" },
		u = { "<cmd>RustMoveItemUp<cr>", "move item up" },
		d = { "<cmd>RustMoveItemDown<cr>", "move item down" },
		g = { "<cmd>RustViewCrateGraph<cr>", "crate graph" },
		w = { "<cmd>RustReloadWorkspace<cr>", "reload workspace" },
		e = { "<cmd>RustOpenExternalDocs<cr>", "external docs" },
		s = { "<cmd>RustSSR<cr>", "search and replace" },
		b = { "<cmd>RustStartStandaloneServerForBuffer<cr>", "standalone server" },
		y = { "<cmd>RustDebuggables<cr>", "debug" },
	}
}

wk.register(leader, { prefix = "<leader>" })


local visual = {

}
