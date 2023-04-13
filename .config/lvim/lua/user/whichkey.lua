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
