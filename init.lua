vim.cmd("autocmd!")
vim.scriptencoding="utf-8"

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local options = {
  -- Make line numbers default
  number = true,
  -- ファイルのエンコーディングをUTF-8に設定
  encoding = "utf-8",
  -- ファイルを保存する際のエンコーディングをUTF-8に設定
  fileencoding = "utf-8",
  -- ターミナルのウィンドウタイトルを現在編集中のファイル名に設定
  title = true,
  -- 特殊文字を可視化
  list = true,
  -- 特殊文字の表示方法を定義
  listchars = { tab = '>>', trail = '-', nbsp = '+' },
  -- タブをスペースに展開
  expandtab = true,
  -- 自動インデント時のスペース数を2に設定
  shiftwidth = 2,
  -- タブの幅を2スペースに設定
  tabstop = 2,
  -- ファイルのバックアップを作成しない
  backup = false,
  -- システムのクリップボードとNeovimのクリップボードを共有
  clipboard = "unnamedplus",
  -- コマンドラインの高さを1行に設定
  cmdheight = 1,
  -- 補完オプションを設定
  completeopt = { "menuone", "noselect" },
  -- 検索した文字列をハイライト表示
  hlsearch = true,
  -- 検索において大文字と小文字を区別しない
  ignorecase = true,
  -- すべてのモードでマウス操作を有効に
  mouse = "a",
  -- モード（INSERTなど）を表示
  showmode = true,
  -- 常にタブラインを表示
  showtabline = 2,
  -- 大文字が含まれている場合のみ、大文字と小文字を区別して検索
  smartcase = true,
  -- スマートインデントを有効に
  smartindent = true,
  -- スワップファイルを作成しない
  swapfile = false,
  -- アンドゥ情報をファイルに保存し、セッション間でアンドゥを可能に
  undofile = true,
  -- 書き込み中にバックアップファイルを作成しない
  writebackup = false,
  -- シェルとしてbashを使用
  shell = "bash",
  backupskip = { "/tmp/*", "/private/tmp/*" },
  -- カーソルのある行をハイライト表示
  cursorline = true,
  -- 行番号を表示
  number = true,
  -- 行番号の表示幅を4に設定
  numberwidth = 4,
  -- サインカラム（エラーマーカーなどの表示領域）を常に表示
  signcolumn = "yes",
  -- 長い行を折り返さない
  wrap = false,
  -- ウィンドウの透過度を設定
  winblend = 10,
  -- 縦スクロールのオフセットを設定
  scrolloff = 8,
  -- 横スクロールのオフセットを設定
  sidescrolloff = 8,
  sessionoptions = { "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" },
  whichwrap = "b,s,h,l,[,],<,>"
}
for k, v in pairs(options) do
        vim.opt[k] = v
end

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local opts = { noremap = true, silent = true }
--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)
keymap("n", "<leader>y", ":let @+ = expand('%:p:h')<CR>", opts )
keymap("n", "<leader>p", [[:execute 'cd' fnameescape(substitute(@+,'\n','',''))<CR>]],opts )
keymap("n", "<leader>.", [[:execute 'cd' fnameescape(substitute(expand('%:p:h'),'\n','',''))<CR>]],opts )
-- terminal
keymap("n", "tt", ":terminal<CR>", opts)
-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)
keymap("n", "s\\", "<C-w><", opts)
keymap("n", "s`", "<C-w>>", opts)
keymap("n", "s=", "<C-w>+", opts)
keymap("n", "s-", "<C-w>-", opts)
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)
keymap("n", "so", "<C-w>o", opts)
keymap("n", "sc", "<C-w>c", opts)
keymap("n", "s,", "<cmd>bprev<CR>",opts)
keymap("n", "s.", "<cmd>bnext<CR>",opts)

-- Insert --
-- Press jj fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)

-- Terminal --
-- Press ESC Terminal-normal --
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("t", "<C-w>n", "<CMD>new<CR>", opts)
keymap("t", "<C-w>q", "<CMD>quit<CR>", opts)
keymap("t", "<C-w>c", "<CMD>close<CR>", opts)
keymap("t", "<C-w>j", "<CMD>wincmd j<CR>", opts)
keymap("t", "<C-w>h", "<CMD>wincmd h<CR>", opts)
keymap("t", "<C-w>k", "<CMD>wincmd k<CR>", opts)
keymap("t", "<C-w>l", "<CMD>wincmd l<CR>", opts)
keymap("t", "<C-q>", "<C-\\><C-n>:q<CR>", opts)

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
--Terminal利用時の設定
autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = 'startinsert'
})
autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = 'setlocal nonumber'
})
autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = 'setlocal norelativenumber'
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- stdpath 'data' is ex [~/.local/share/nvim/]
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
-- Setup lazy.nvim
require("lazy").setup({
  spec = {

    { -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      opts = {
        -- delay between pressing a key and opening which-key (milliseconds)
        -- this setting is independent of vim.opt.timeoutlen
        delay = 0,

        triggers = {
          { "<auto>", mode = "nixsotc" },
          { "s", mode = { "n", "v" } },
        },
        icons = {
          -- set icon mappings to true if you have a Nerd Font
          mappings = vim.g.have_nerd_font,
          -- If you are using a Nerd Font: set icons.keys to an empty table which will use th
          -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
          keys = vim.g.have_nerd_font and {} or {
            Up = '<Up> ',
            Down = '<Down> ',
            Left = '<Left> ',
            Right = '<Right> ',
            C = '<C-…> ',
            M = '<M-…> ',
            D = '<D-…> ',
            S = '<S-…> ',
            CR = '<CR> ',
            Esc = '<Esc> ',
            ScrollWheelDown = '<ScrollWheelDown> ',
            ScrollWheelUp = '<ScrollWheelUp> ',
            NL = '<NL> ',
            BS = '<BS> ',
            Space = '<Space> ',
            Tab = '<Tab> ',
            F1 = '<F1>',
            F2 = '<F2>',
            F3 = '<F3>',
            F4 = '<F4>',
            F5 = '<F5>',
            F6 = '<F6>',
            F7 = '<F7>',
            F8 = '<F8>',
            F9 = '<F9>',
            F10 = '<F10>',
            F11 = '<F11>',
            F12 = '<F12>',
          },
        },
      }
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      opts = {
        source_selector = {
            winbar = true,
            statusline = true, 
        }
      }
    }

    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  --checker = { enabled = true },
})

