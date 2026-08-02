return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- Setup treesitter with default install directory
		require("nvim-treesitter").setup({})

		-- Install common parsers asynchronously, but only the ones not yet installed.
		-- This avoids spamming downloads (and the associated UI noise) on every startup.
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
			"xml",
			"markdown",
			"markdown_inline",
			"apex",
			"soql",
			"sosl",
			"sflog",
			"go",
			"c",
			"cpp",
			"cuda",
			"cmake",
			"rust",
			"toml",
			"dockerfile",
			"hcl",
			"terraform",
		}

		local ts = require("nvim-treesitter")
		local installed = ts.get_installed("parsers") or {}
		local to_install = vim.tbl_filter(function(p)
			return not vim.list_contains(installed, p)
		end, parsers)

		if #to_install > 0 then
			ts.install(to_install)
		end

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
