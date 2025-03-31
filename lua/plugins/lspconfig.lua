return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup mason first
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "jdtls", "rust_analyzer", "ts_ls", "tailwindcss" } -- your servers here
      })

      -- LSP config
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        opts.desc = "Show LSP references"
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = "Go to declaration"
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

        opts.desc = "Show LSP type definitions" vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostic"
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)

        opts.desc = "Go to previous diagnostics"
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)

        opts.desc = "Go to next diagnostics"
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

        opts.desc = "Show documentation"
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set('n', '<leader>rl', '<cmd>LspRestart<CR>', opts)

        opts.desc = "Signature help"
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
      end

      -- Setup each server
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        -- Override for specific servers
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          })
        end,
        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "JavaSE-17",
                      path = "/usr/lib/jvm/java-17-openjdk-amd64",
                      default = true,
                    }
                  }
                }
              }
            }
          })
        end,
      })


      -- Keymaps
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    end
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        completition = {
          completeopt = 'menu,menuone,preview,noselect',
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "codeium" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  }
}
