-- Telescope.nvim Setup
return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-live-grep-args.nvim'
	},
	-- Telescope live-grep-args extension setup
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("live_grep_args")
	end
}
