return {

	{ 'numtostr/comment.nvim', opts = {} },

	{
		"L3MON4D3/LuaSnip",
		version = "v2.4", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},

	{
		"shaunsingh/nord.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme nord")
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

	{
		"mason-org/mason.nvim",
		opts = {}
	},

	{
		'altermo/ultimate-autopair.nvim',
		event={'InsertEnter','CmdlineEnter'},
		branch='v0.6', --recommended as each new version will have breaking changes
		opts={
			--Config goes here
		}
	},

	-- parser (analizador)
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
	},

	-- finder
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

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
				theme = 'nord',
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
	},

	-- funny
	{
		"theprimeagen/vim-be-good",
        cmd = "VimBeGood"
	},

    -- Competitive Programming
    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        -- config = function() require('competitest').setup() end,
    },

    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
        dependencies = {
            -- include a picker of your choice, see picker section for more details
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
             injector = { ---@type table<lc.lang, lc.inject>
                ["cpp"] = {
                    imports = function()
                        -- return a different list to omit default imports
                        return { "#include <bits/stdc++.h>", "using namespace std;" }
                    end,
                    after = "int main() {}",
                },
             ---@type string
            arg = "leetcode.nvim"
            },
        },
        cmd = "Leet"
    }

}
