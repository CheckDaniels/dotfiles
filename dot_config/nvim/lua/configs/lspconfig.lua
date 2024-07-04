local base = require("nvchad.configs.lspconfig")

local on_attach = base.on_attach
local capabilities = base.capabilities
local on_init = base.on_init

local lspconfig = require("lspconfig")
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup ({
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
})

lspconfig.pyright.setup({
  -- root_dir = function() return vim.fn.getcwd() end,
  cmd = { "venv/bin/pyright-langserver", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  settings = {
    python = {
      venvPath = {function() return vim.fn.getcwd() end,},
      venv = "venv"
    },
  }
})

-- typescript
lspconfig.tsserver.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})
