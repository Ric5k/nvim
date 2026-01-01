return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- indent-blankline v3 以降はこの指定が必要
    opts = {
      indent = {
        char = "│", -- インデントの縦棒（好きな記号に変更可能）
      },
      scope = {
        enabled = false,
        show_end = false,
      },
    },
  },
}
