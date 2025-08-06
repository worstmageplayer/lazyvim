return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  opts = {
    servers = {
      lua_ls = {},
      pyright = {},
      ts_ls = {},
      clangd = {},
      rust_analyzer = {},
    }
  },

  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end

    require('lspconfig').lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }

    require('lspconfig').rust_analyzer.setup {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = 'clippy',
          },
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true,
          }
        }
      },
      root_dir = require('lspconfig').util.root_pattern('Cargo.toml'),
    }

  end
}
