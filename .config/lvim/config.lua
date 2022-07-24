-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "catppuccin"
lvim.transparent_window = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Space>r"] = ":Telescope buffers<cr>"
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
-- lvim.builtin.nvimtree.setup.auto_close = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true

lvim.plugins = {
	-- ##### Appearance #####
	{ "folke/tokyonight.nvim" },
	{ "catppuccin/nvim" },
	{
		"danilamihailov/beacon.nvim",
	},
	{
		"folke/todo-comments.nvim",
		-- event = "BufRead",
		event = "BufEnter",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			})
		end,
	},
	-- ##### Misc #####
	{
		"folke/persistence.nvim",
		-- event = "BufReadPre", -- this will only start session saving when an actual file was opened
		event = "BufEnter",
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{
		"windwp/nvim-spectre",
		event = "BufEnter",
		config = function()
			require("spectre").setup({
				mapping = {
					["send_to_qf"] = {
						map = "<leader>Q",
						cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
						desc = "send all item to quickfix",
					},
				},
			})
		end,
	},
	{
		"EthanJWright/vs-tasks.nvim",
	},
	{ "SmiteshP/nvim-gps" },
	{ "christoomey/vim-tmux-navigator" },
	-- #####  Git #####
	{
		"sindrets/diffview.nvim",
		-- event = "BufRead",
	},
	{
		"f-person/git-blame.nvim",
	},
	{
		"TimUntersberger/neogit",
	},
	-- ##### Additional lang support #####
	{
		"tikhomirov/vim-glsl",
	},
}

--- Nvim-tree configs
lvim.builtin.nvimtree.setup.view.auto_resize = true
lvim.builtin.bufferline.options.offsets = {
	{
		filetype = "NvimTree",
		text = "",
		text_align = "left",
	},
}
-- Session keymaps
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
-- Find and Replace keymaps
lvim.builtin.which_key.mappings["s"].s = {
	"<cmd> lua require('spectre').open_file_search()<cr>",
	"Find and Replace",
}
-- Git related keymaps
lvim.builtin.which_key.mappings["g"].d = { "<cmd>DiffviewOpen<CR>", "Open Diff" }
lvim.builtin.which_key.mappings["g"].D = { "<cmd>DiffviewClose<CR>", "Close Diff" }
lvim.builtin.which_key.mappings["g"].s = { "<cmd>Neogit<CR>", "Status" }
require("neogit").setup({
	integrations = {
		diffview = true,
	},
})
-- vs-tasks keymaps
lvim.builtin.which_key.mappings["t"] = {
	name = "Tasks",
	a = {
		"<cmd>lua require('telescope').extensions.vstask.tasks()<cr>",
		"Tasks",
	},
	i = {
		"<cmd>lua require('telescope').extensions.vstask.inputs()<cr>",
		"Task Inputs",
	},
}

local gps = require("nvim-gps")
gps.setup()
lvim.builtin.lualine.sections.lualine_c = { { gps.get_location, cond = gps.is_available } }

-- Formatters configuration
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettierd",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescript",
			"json",
			"markdown",
		},
	},
	{

		command = "stylua",
		filetypes = {
			"lua",
		},
	},
})

-- Linters configuration
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		exe = "eslint",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescript",
			"vue",
		},
	},
	{
		command = "codespell",
		filetypes = { "javascript", "python", "lua" },
	},
})

vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight clear CursorLineNR")
-- vim.cmd('source ~/.config/lvim/init.vim')
