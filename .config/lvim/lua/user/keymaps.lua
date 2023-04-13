-- Keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Space>r"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["<Space>H"] = ":%s/<<C-r><C-w>>//g<Left><Left>"
lvim.keys.normal_mode["H"] = "<Cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["L"] = "<Cmd>BufferLineCycleNext<CR>"

-- Misc
vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight clear CursorLineNR")
