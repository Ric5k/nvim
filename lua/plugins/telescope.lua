-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0', -- v0.2.0よりも安定版の0.1.8や最新の0.1.xが一般的です
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- 1. Telescopeの初期化
        require('telescope').setup({
            defaults = {
                -- ここにプレビューの出し方などのオプションを書けます（空でもOK）
            }
        })

        -- 2. キーマップの設定（これを書かないと起動できません）
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "ファイル検索" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "全文検索" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "開いているバッファ" })
    end
}
