return {
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
        ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls" },
      })

      -- 補完のための能力（Capabilities）を取得
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 言語サーバーのリスト
      local servers = { "lua_ls", "rust_analyzer", "ts_ls" }

      -- 【重要】Neovim 0.11 以降の新しい書き方
      for _, server in ipairs(servers) do
        -- 以前の require('lspconfig')[server].setup() は非推奨
        vim.lsp.config(server, {
          capabilities = capabilities,
          -- 必要ならここに cmd や root_dir を追加
        })
        -- サーバーを有効化
        vim.lsp.enable(server)
      end

      -- LSPキーマップ（定義ジャンプなど）
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },

  -- nvim-cmp の設定（ここは変更なし）
  {
    "hrsh7th/nvim-cmp",
    -- ... (前回と同じ内容)
  }
}
