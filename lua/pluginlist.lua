return {

	{ 'numtostr/comment.nvim', opts = {} },

	{
		"L3MON4D3/LuaSnip",
		version = "v2.4", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme gruvbox")
		end
	},

	"neovim/nvim-lspconfig",
	-- 'folke/neodev.nvim', -- new
	-- lazydev is the new one
	-- completion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'l3mon4d3/luaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
			'hrsh7th/cmp-nvim-lsp',
		},
	},

	-- parser (analizador)
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
	},

	-- finder
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	--
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},

	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- decorations
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("lualine").setup({
				icons_enabled = true,
				theme = 'auto',
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
	},

	-- funny
	{
		"theprimeagen/vim-be-good"
	}

}
