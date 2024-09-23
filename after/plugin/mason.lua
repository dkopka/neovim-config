require("mason").setup()
local ensure_installed = { 'clangd', 'rust-analyzer', 'stylua' }

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
--    local server = ensure_installed[server_name] or {}
    server_name.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_name.capabilities or {})
    lspconfig[server_name].setup(server_name)
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

local lspconfig = require('lspconfig')
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
