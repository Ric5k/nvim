return {
  -- ==========================================
  -- LSP & 補完設定 (Inlay Hints 対応版)
  -- ==========================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "svelte" },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 各サーバーごとの個別設定
      local server_configs = {
        lua_ls = {},
        svelte = {},
        -- Rust の Inlay Hints 設定
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = {
                typeHints = { enable = true },
                parameterHints = { enable = true },
                chainingHints = { enable = true },
              },
            },
          },
        },
        -- TypeScript の Inlay Hints 設定
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      }

      -- Neovim 0.11+ 対応のセットアップループ
      for server, config in pairs(server_configs) do
        config.capabilities = capabilities
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      -- LSPが接続された時の共通処理
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- 【必須機能】Inlay Hints を有効化
          if client and client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          -- キーマップ設定
          local opts = { buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'f', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          
          -- 【おまけ】Leader + i でヒントの表示/非表示を切り替え
          vim.keymap.set('n', '<leader>i', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
          end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
        end,
      })
    end,
  },

  -- ==========================================
  -- 補完エンジン & スニペット (friendly-snippets)
  -- ==========================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 100 },
          { name = 'luasnip',  priority = 80 },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end,
  },

  -- ==========================================
  -- 自動ペアリング (() {} "" など)
  -- ==========================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },

  -- ==========================================
  -- Treesitter (ハイライト & Svelte/TS/Rust対応)
  -- ==========================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "rust", "typescript", "tsx", "javascript", "svelte", "html", "css" },
        highlight = { enable = true },
        autotag = { enable = true },
      })
    end,
  },
}
