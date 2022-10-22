-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "gruvbox"
vim.o.background = "dark" -- or "light" for light mode

lvim.transparent_window = true

-- Keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Space>r"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["<Space>H"] = ":%s/<<C-r><C-w>>//g<Left><Left>"
-- TODO: User Config for predefined plugins
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false

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
	{ "catppuccin/nvim" },
	-- { "morhetz/gruvbox" },
	{ "ellisonleao/gruvbox.nvim" },
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
	-- ##### Misc #####
	-- { "github/copilot.vim" },
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
					cmp = {
						enabled = true,
						method = "getCompletionsCycling",
					},
				})
			end, 100)
		end,
	},
	{ "zbirenbaum/copilot-cmp", after = { "copilot.lua", "nvim-cmp" } },
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
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"samodostal/image.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		{ "m00qek/baleia.nvim", tag = "v1.2.0" },
		require("image").setup({
			render = {
				min_padding = 5,
				show_label = true,
				use_dither = true,
				foreground_color = true,
				background_color = true,
			},
			events = {
				update_on_nvim_resize = true,
			},
		}),
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
-- lvim.builtin.nvimtree.setup.view.auto_resize = true
-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.bufferline.options.offsets = {
	{
		filetype = "NvimTree",
		text = "",
		text_align = "left",
	},
}
lvim.builtin.notify.active = false
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
		exe = "eslint_d",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescript",
			"vue",
		},
	},
	{
		command = "codespell",
		filetypes = { "javascript", "python", "lua", "typescript" },
	},
})

-- Overriding tssever confis to make it use absolute imports like a man
local opts = {
	-- https://github.com/typescript-language-server/typescript-language-server#initializationoptions
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
	single_file_support = true,
}

require("lvim.lsp.manager").setup("tsserver", opts)

-- Copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "Copilot 🤖"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- Misc
vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight clear CursorLineNR")
