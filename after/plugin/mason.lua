local lspconfig = require('lspconfig')
require("mason").setup()
local ensure_installed = { 'pyright', 'gopls', 'clangd', 'rust_analyzer' }

-- Keybindings for LSP features
local on_attach_fn = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end


-- https://discourse.nixos.org/t/neovim-cannot-start-lsp-because-clangd-is-not-found/38902/3
local file = io.open('/etc/os-release', 'r')
if file then
    local content = file:read '*all'
    file:close()
    if string.find(content, 'ID=nixos') then
        vim.g.system_id = 'nixos'
    end
end

local setup_servers = function(server_name)
    local server = ensure_installed[server_name] or {}
    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities or {}, server_name.capabilities or {})
    lspconfig[server_name].setup(server)
end

--local ensure_installed = vim.tbl_keys(servers or {})
local extra_tools = {
    'stylua', -- Used to format Lua code
}

if vim.g.system_id == 'nixos' then
    for _, server_name in pairs(ensure_installed) do
        setup_servers(server_name)
    end
else
    vim.list_extend(ensure_installed, extra_tools)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup { handlers = { setup_servers } }
end

-- Configure rust-analyzer
lspconfig.rust_analyzer.setup{
    on_attach = on_attach_fn,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        }
    }
}
-- Configure clangd
lspconfig.clangd.setup{
    on_attach = on_attach_fn,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = { "/etc/profiles/per-user/dkopka/bin/clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    settings = {
        clangd = {
            fallbackFlags = { "-std=c11" }
        }
    }
}
