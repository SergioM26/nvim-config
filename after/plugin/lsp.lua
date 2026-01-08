-- LSP Configuration using new Neovim 0.11+ API

local on_attach = function(_, bufnr)
  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  -- LSP keymaps
  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)
  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)
  bufmap('K', vim.lsp.buf.hover)

  -- Telescope LSP integrations
  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  -- Format command
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

-- Setup completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lua Language Server
vim.lsp.config('luals', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim', 'require' },
        unusedLocalExclude = { '_*' },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = { enable = false },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Enable the LSP servers
vim.lsp.enable('luals')

-- Load additional LSP servers (optional)
-- Uncomment the next line to enable additional LSP servers
require('lsp-servers').setup_additional_servers()
