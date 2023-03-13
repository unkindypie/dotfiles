-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "gruvbox"
-- lvim.colorscheme = "tokyonight-day"

lvim.transparent_window = true

-- Keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Space>r"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["<Space>H"] = ":%s/<<C-r><C-w>>//g<Left><Left>"
lvim.keys.normal_mode["H"] = "<Cmd>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["L"] = "<Cmd>BufferLineCycleNext<CR>"

-- TODO: User Config for predefined plugins
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true

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
	{
		"ellisonleao/gruvbox.nvim",
	},
	{
		"danilamihailov/beacon.nvim",
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = "sine", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
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
					filetypes = {
						python = true,
						javascriptreact = true,
						javascript = true,
						typescript = true,
						typescriptreact = true,
						json = true,
						markdown = true,
					},
					panel = { enabled = false },
					suggestion = {
						enabled = true,
						auto_trigger = true,
						keymap = {
							accept = "<C-o>",
							accept_word = false,
							accept_line = false,
							next = "<M-]>",
							prev = "<M-[>",
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
			require("copilot_cmp").setup()
		end,
		after = { "copilot.lua", "nvim-cmp" },
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
	},
	{ "SmiteshP/nvim-gps" },
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

-- Copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "Copilot 🤖"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

--- Nvim-tree configs
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
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

-- Formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettierd",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescript",
			"typescriptreact",
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
	{ exe = "black", filetypes = { "python" } },
	{ exe = "isort", filetypes = { "python" } },
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
		command = "flake8",
		filetypes = {
			"python",
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

-- Setup dap for python
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
	-- require("dap-python").setup("python")
end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function()
	require("dap-python").test_runner = "pytest"
end)

table.insert(require("dap").configurations.python, {
	type = "python",
	request = "launch",
	name = "FastAPI module",
	module = "uvicorn",
	args = {
		"app.main:app",
		-- '--reload', -- doesn't work
		"--use-colors",
	},
	pythonPath = "python",
	console = "integratedTerminal",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "python" },
	callback = function()
		lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
		lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
		lvim.builtin.which_key.vmappings["d"] = {
			name = "Debug",
			s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
		}
	end,
})

-- Misc
vim.cmd("highlight NonText guibg=none")
vim.cmd("highlight Normal guibg=none")
vim.cmd("highlight clear CursorLineNR")
