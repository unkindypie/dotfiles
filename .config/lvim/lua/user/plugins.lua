lvim.plugins = {
	-- ##### Appearance #####
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"danilamihailov/beacon.nvim",
	},
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
	},
	{
		"catppuccin/nvim",
	},
	-- ##### Misc #####
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					panel = { enabled = false },
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<C-o>",
							accept_word = false,
							accept_line = false,
							next = "<C-p>",
							prev = "<C-i>",
							dismiss = "<C-]>",
						},
					},
					plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
				})
			end, 100)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({ clear_after_cursor = false })
		end,
		after = { "copilot.lua", "nvim-cmp" },
	},
	{
		-- Converts snake case to camel case (crs) and camel case to snake case (crc)
		"tpope/vim-abolish",
	},
	{
		"folke/persistence.nvim",
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
	-- {
	--   "samodostal/image.nvim",
	--   requires = {
	--     "nvim-lua/plenary.nvim",
	--   },
	--   { "m00qek/baleia.nvim" },
	--   require("image").setup({
	--     render = {
	--       min_padding = 5,
	--       show_label = true,
	--       use_dither = true,
	--       foreground_color = true,
	--       background_color = true,
	--     },
	--     events = {
	--       update_on_nvim_resize = true,
	--     },
	--   }),
	-- },
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
		event = { "VimEnter" },
		config = function()
			require("vstask").setup({
				terminal = "toggleterm",
			})
		end,
	},
	{ "christoomey/vim-tmux-navigator" },
	{
		"wakatime/vim-wakatime",
	},
	-- #####  Git #####
	{
		"sindrets/diffview.nvim",
	},
	{
		"f-person/git-blame.nvim",
	},
	{
		"TimUntersberger/neogit",
	},
	-- {
	-- 	"akinsho/git-conflict.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("git-conflict").setup()
	-- 	end,
	-- },
	-- ##### Additional lang support #####
	{
		"tikhomirov/vim-glsl",
	},
	-- #### Debugging
	{
		"mfussenegger/nvim-dap-python",
	},
}
