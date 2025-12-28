-- lua/plugins/oil.lua

return {
  'stevearc/oil.nvim',
  -- 依存関係（アイコン用）
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  
  -- lazy = false は推奨設定。起動時から Oil が Netrw を置き換えるようにする
  lazy = false,

  -- Oil自体の挙動設定
  opts = {
    default_file_explorer = true, -- Netrwを完全に置き換える
    columns = {
      "icon", -- アイコンを表示
    },
    view_options = {
      show_hidden = true, -- 隠しファイル（.gitなど）も表示
    },
    -- ウィンドウの設定（浮かせたい場合はここをいじる）
    win_options = {
      wrap = false,
    },
  },

  -- キーマップの設定
  config = function(_, opts)
    -- opts の内容を使って Oil をセットアップ
    require("oil").setup(opts)
	vim.keymap.set("n", "<leader>e", "<CMD>Oil .<CR>", { desc = "Open Oil Explorer" })
  end,
}
