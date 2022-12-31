local actions = require("telescope.actions")

require("telescope").setup {
	defaults = {
		prompt_prefix = "  ",
		selection_caret = " ",
		entry_prefix = "  ",
		scroll_strategy = "limit",
		file_ignore_patterns = {
			"^.git/", ".cache", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip", "%.gz",
			"%.jpeg", "%.jpg", "%.png", "%.svg", "%.otf", "%.ttf",
			"__pychace__", "%.ipynb", "%.sqlite3", "%.hdf5", "%.npz"
		},

		layout_config = {
			horizontal = {
				preview_width = 0.5,
			},
		},
		mappings = {
			-- change mapping for move previous/next in insert mode
			i = {
				["<ESC>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<ESC>"] = actions.close,
			}
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                   -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true,    -- override the file sorter
			case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
		},
	},
}
