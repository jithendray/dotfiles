vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-tree/nvim-tree.lua",          -- File Explorer
  "nvim-tree/nvim-web-devicons",      -- Icons
  "neovim/nvim-lspconfig",            -- LSP
  "hrsh7th/nvim-cmp",                 -- Autocompletion
  "hrsh7th/cmp-nvim-lsp",
  "nvim-treesitter/nvim-treesitter",  -- Syntax Highlighting
  "nvim-telescope/telescope.nvim",    -- Fuzzy Finder
  "akinsho/toggleterm.nvim",          -- Terminal
 -- "jiangmiao/auto-pairs",             -- Auto brackets/quotes
 "windwp/nvim-autopairs", -- Auto brackets/quotes
 "tpope/vim-commentary"              -- Easy Commenting
})

require("nvim-tree").setup({
  view = {
    side = "right",
    width = 30
  },
  renderer = {
    icons = {
      glyphs = {
        default = ">",    -- For files
        symlink = "->",
        folder = {
          arrow_closed = "+",  -- Collapsed folder
          arrow_open = "-",    -- Expanded folder
          default = "[F]",     -- Folder closed
          open = "[O]",        -- Folder opened
          empty = "[E]",       -- Empty folder
          empty_open = "[EO]", -- Empty folder expanded
        },
        git = {
          unstaged = "U",
          staged = "S",
          unmerged = "M",
          renamed = "R",
          untracked = "?",
          deleted = "D",
          ignored = "I"
        }
      }
    }
  }
})


vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

require("telescope").setup({})
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { silent = true })

require("toggleterm").setup({
  direction = "horizontal", -- You can change this to "vertical" or "float"
  size = 15,
  open_mapping = [[<C-t>]],
  persist_mode = false,
})




local lspconfig = require("lspconfig")

lspconfig.pyright.setup({})  -- Python LSP
lspconfig.ts_ls.setup({}) -- JS/TS LSP

vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", { silent = true })

local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true })
  }),
  sources = {
    { name = "nvim_lsp" }
  }
})


require("nvim-autopairs").setup({})

vim.opt.number = true   -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Use spaces instead of tabs

vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })  -- Save file with Ctrl+s
vim.keymap.set("n", "<C-q>", ":q<CR>", { silent = true })  -- Quit with Ctrl+q
