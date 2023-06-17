-- general
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "gruvbox"
-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "catppuccin-frappe"

lvim.transparent_window = true

-- TODO: User Config for predefined plugins
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.project.exclude_dirs = { "*/packages/*", "*/apps/*" }

reload("user.keymaps")

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

reload("user.plugins")

-- Copilot
lvim.builtin.cmp.formatting.source_names["copilot"] = "Copilot 🤖"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- lvim.builtin.cmp.formatting.format = require("tailwindcss-colorizer-cmp").formatter

--- Nvim-tree configs
lvim.builtin.nvimtree.setup.auto_reload_on_write = true
lvim.builtin.bufferline.options.offsets = {
	{
		filetype = "NvimTree",
		text = "",
		text_align = "left",
	},
}

reload("user.whichkey")

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
		-- exe = "eslint_d",
		exe = "eslint",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescript",
			"typescriptreact",
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
		filetypes = { "javascript", "python", "lua", "typescript", "typescriptreact", "javascriptreact" },
	},
})

-- Overriding tssever config to make it use absolute imports like a sane person
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
