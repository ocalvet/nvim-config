return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- Setup treesitter with default install directory
		require("nvim-treesitter").setup({})

		-- Install common parsers asynchronously
		local parsers = {
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"python",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"yaml",
			"markdown",
			"go",
		}

		-- Install parsers in the background (non-blocking)
		require("nvim-treesitter").install(parsers)

		-- Enable treesitter highlight for every buffer that has a parser available.
		-- The new main-branch API does not enable highlight automatically.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
			callback = function(event)
				local ok = pcall(vim.treesitter.start, event.buf)
				if not ok then
					-- No parser for this filetype — fall back to legacy syntax
					vim.cmd("syntax enable")
				end
			end,
		})
	end,
}
