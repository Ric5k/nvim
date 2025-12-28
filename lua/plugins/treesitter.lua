-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- モジュールの読み込みを安全に行う
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then return end

      configs.setup({
        -- スペル修正: highlight
        highlight = {
          enable = true,
        },
        -- スペル修正: enable
        indent = { enable = true },
        -- スペル修正: autotag (別途プラグインが必要な場合が多いですが、設定としてはこれ)
        autotag = { enable = true },
        ensure_installed = {
          "lua",
          "rust",
          "typescript",
          "query",
          "vim",
          "vimdoc",
        },
        auto_install = true, -- true にしておくと自動で足りないものを入れてくれるので楽です
      })
    end,
  },
}
