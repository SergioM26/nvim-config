local M = {}

local function get_lsp_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	local on_attach = function(_, bufnr)
		local bufmap = function(keys, func)
			vim.keymap.set('n', keys, func, { buffer = bufnr })
		end

		bufmap('<leader>r', vim.lsp.buf.rename)
		bufmap('<leader>a', vim.lsp.buf.code_action)
		bufmap('gd', vim.lsp.buf.definition)
		bufmap('gD', vim.lsp.buf.declaration)
		bufmap('gI', vim.lsp.buf.implementation)
		bufmap('<leader>D', vim.lsp.buf.type_definition)
		bufmap('K', vim.lsp.buf.hover)
		bufmap('gr', require('telescope.builtin').lsp_references)
		bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
		bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)


		vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
			vim.lsp.buf.format()
		end, {})
	end

	return { on_attach = on_attach, capabilities = capabilities }
end

-- Setup additional LSP servers
function M.setup_additional_servers()
	local config = get_lsp_config()

	-- JavaScript/TypeScript
	vim.lsp.config('ts_ls', {
		cmd = { 'typescript-language-server', '--stdio' },
		filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
		root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('ts_ls')

	-- C/C++
	vim.lsp.config('clangd', {
		cmd = { 'clangd' },
		filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
		root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('clangd')

	-- Python
	vim.lsp.config('pylsp', {
		cmd = { 'pylsp' },
		filetypes = { 'python' },
		root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('pylsp')

	-- Bash
	vim.lsp.config('bashls', {
		cmd = { 'bash-language-server', 'start' },
		filetypes = { 'sh', 'bash' },
		root_markers = { '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('bashls')

	-- CSS
	vim.lsp.config('cssls', {
		cmd = { 'vscode-css-language-server', '--stdio' },
		filetypes = { 'css', 'scss', 'less' },
		root_markers = { 'package.json', '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('cssls')

	-- HTML
	vim.lsp.config('html', {
		cmd = { 'vscode-html-language-server', '--stdio' },
		filetypes = { 'html', 'templ' },
		root_markers = { 'package.json', '.git' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('html')

	-- PHP
	vim.lsp.config('phpactor', {
		cmd = { 'phpactor', 'language-server' },
		filetypes = { 'php' },
		root_markers = { 'composer.json', '.git' },
		init_options = {
			['language_server_phpstan.enabled'] = false,
			['language_server_psalm.enabled'] = false,
		},
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('phpactor')

	-- Nix
	vim.lsp.config('nil_ls', {
		cmd = { 'nil' },
		filetypes = { 'nix' },
		root_markers = { 'flake.nix', 'shell.nix', '.git' },
		settings = {
			['nil'] = {
				formatting = { command = { 'alejandra' } },
			},
		},
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "nix",
		callback = function()
			vim.opt_local.tabstop = 2
			vim.opt_local.shiftwidth = 2
			vim.opt_local.expandtab = true
		end
	})
	vim.lsp.enable('nil_ls')

	-- QML
	vim.lsp.config('qml', {
		cmd = { 'qmlls' },
		filetypes = { 'qml' },
		root_markers = { '.git', '.qmlproject', '.qml.ini' },
		on_attach = config.on_attach,
		capabilities = config.capabilities,
	})
	vim.lsp.enable('qml')
end

return M
