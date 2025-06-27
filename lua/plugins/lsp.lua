
return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.pyright.setup {
      capabilities = capabilities,
    }

    lspconfig.ts_ls.setup {
      capabilities = capabilities,
    }

    lspconfig.clangd.setup {
      capabilities = capabilities,
    }
  end,
}
