-- lua/plugins/colorscheme.lua
return {
  {
    "navarasu/onedark.nvim",
    lazy = false,    -- 起動時に読み込む
    priority = 1000, -- 他のプラグインより先に読み込む
    config = function()
      require('onedark').setup({
        -- スタイルを選択: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
        -- 'warmer' や 'deep' にすると、色がはっきりして「色がない」感じが解消されやすいです
        style = 'warmer', 
        
        -- Treesitterのハイライトを明示的に有効にする
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        
        -- 補完ウィンドウなどの見た目を綺麗にする
        diagnostics = {
          darker = true, -- 診断情報の背景を少し暗くして見やすくする
          undercurl = true, -- エラーの下線を波線にする
        },
      })
      require('onedark').load()
    end,
  },
}
