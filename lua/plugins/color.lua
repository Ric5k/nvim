-- lua/plugins/colorscheme.lua
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon",
        
        -- ここに書くのが正解です
        overrides = function(colors)
          return {
            -- サイドの背景色を消す
            SignColumn = { bg = "none" },
            -- ついでに行番号の背景も消して統一感を出す場合
            LineNr = { bg = "none" },
          }
        end,

        background = {
          dark = "dragon",
          light = "dragon"
        },
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
