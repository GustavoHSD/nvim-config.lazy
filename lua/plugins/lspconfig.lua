return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",  -- Keep mason for installation only
    },
    config = function()
      -- Setup mason for LSP server installation
      require("mason").setup()

      -- LSP config
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local jdtls_on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        opts.desc = "Show LSP references"
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        opts.desc = "Go to declaration"
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

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

        opts.desc = "Organize Imports"
        vim.keymap.set("n", "<leader>o",
        function() vim.lsp.buf.code_action(
          {
            context = { only = { "source.organizeImports" } },
            apply = true
          })
        end)

        opts.desc = "Generate"
        vim.keymap.set("n", "<leader>gg",
        function() vim.lsp.buf.code_action(
          {
            context = { only = { "source.generate" } },
            apply = true
          })
        end)

        opts.desc = "Generate Constructor"
        vim.keymap.set("n", "<leader>gc",
        function() vim.lsp.buf.code_action(
          {
            context = { only = { "source.generateConstructor" } },
            apply = true
          })
        end)

        opts.desc = "Quick Assist"
        vim.keymap.set("n", "<leader>qq",
        function() vim.lsp.buf.code_action(
          {
            context = { only = { "quickassist" } },
            apply = true
          })
        end)

        vim.keymap.set("n", "<leader><Enter>", function()
          require("FTerm").scratch({ cmd = { "mvn", "clean", "package" }})
        end)
      end

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

        opts.desc = "Show LSP type definitions"
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

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

      -- Common configuration for all servers
      local common_config = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Lua
      lspconfig.lua_ls.setup(vim.tbl_extend("force", common_config, {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }))

      -- Python
      lspconfig.pyright.setup(common_config)

      -- Java (JDTLS)
      lspconfig.jdtls.setup(vim.tbl_extend("force", common_config, {
        on_attach = jdtls_on_attach,
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk-amd64",
                  default = true,
                }
              }
            }
          }
        }
      }))

      -- Rust
      lspconfig.rust_analyzer.setup(vim.tbl_extend("force", common_config, {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" }
            },
            diagnostics = {
              enable = true,
              experimental = {
                enable = true
              }
            },
            cargo = {
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true
              },
              features = "all"
            },
            procMacro = {
              enable = true
            },
            inlayHints = {
              enable = true,
              showParameterHints = true,
              parameterHintsPrefix = "<- ",
              otherHintsPrefix = "=> "
            },
            lens = {
              enable = true,
              run = true,
              debug = true,
              implementations = true,
              references = true
            },
            hover = {
              actions = {
                enable = true,
                debug = true,
                gotoTypeDef = true,
                run = true,
                references = true
              }
            },
            completion = {
              postfix = {
                enable = true
              },
              autoimport = {
                enable = true
              }
            },
            files = {
              excludeDirs = { ".git", "target" },
              watcher = "client"
            },
            workspace = {
              symbol = {
                search = {
                  kind = "all_symbols"
                }
              }
            }
          }
        }
      }))

      lspconfig.kotlin_language_server.setup{
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "kotlin" , "kt", "kts"},
        cmd = { os.getenv("HOME") .. "/.local/language_servers/kotlin/server/bin/kotlin-language-server" }
      }

      -- TypeScript
      lspconfig.ts_ls.setup(common_config)

      -- TailwindCSS
      lspconfig.tailwindcss.setup(vim.tbl_extend("force", common_config, {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "cva\\(([^)]*)\\)",
                "[\"']([^\"']*).*?[\"']",
              },
            },
            validate = true,
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error",
              invalidTailwindDirective = "error",
              recommendedVariantOrder = "warning",
            },
            includeLanguages = {
              typescript = "javascript",
              typescriptreact = "javascript",
            },
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          },
        },
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      }))

      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    end
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        completion = {
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
    version = "v2.*",
    build = "make install_jsregexp"
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  }
}
