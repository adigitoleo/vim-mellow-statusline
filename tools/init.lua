-- Download package manager (paq-nvim), see :h paq-bootstrap.
local function clone_paq()
    local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
        return true
    end
    return false
end

-- Install packages and run their setup hooks, bootstrapping package manager if necessary.
local function setup_paq(packages)
    local first_install = clone_paq()
    if first_install then
        vim.cmd.packadd("paq-nvim")
    end
    local paq = require("paq")
    paq(packages)
    paq.install()
    for i, pkg in ipairs(paq._get_hooks()) do
        paq._run_hook(pkg)
    end
end

-- Package manifest and configuration.
setup_paq {
    "savq/paq-nvim",
    -- Test Fugitive integration (git branch name).
    "tpope/vim-fugitive",
    -- Test ALE integration (by adding invalid syntax to this file or opening another file with errors).
    "dense-analysis/ale",
    {  -- Set recommended vim-mellow options.
        "adigitoleo/vim-mellow",
        run = function()
            vim.o.termguicolors = true
            vim.g.mellow_user_colors = true
            vim.cmd "colorscheme mellow"
        end
    },
    {  -- Test gitsigns integration (git file status, and HEAD if Fugitive is disabled/not installed).
        "lewis6991/gitsigns.nvim",
        run = function() require("gitsigns").setup() end
    },
}

-- Install local plugin.
vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("PWD")

-- Set recommended nvim options.
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = -1
vim.o.shiftwidth = 0
vim.o.shiftround = true
