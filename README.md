# High-Performance Neovim Configuration

A lightweight, fast Neovim configuration optimized for text editing without any external plugins.

## Features

### 🚀 Performance Optimizations
- Disabled unnecessary built-in plugins (netrw, gzip, zip, etc.)
- Optimized updatetime and timeout settings
- Limited syntax highlighting to first 240 columns
- Reduced memory usage for pattern matching
- No backup or swap files for faster file operations

### 📝 Text Editing Features
- Smart indentation with 2-space tabs
- Relative line numbers for better navigation
- Visual indicators for invisible characters
- Persistent undo across sessions
- Auto-reload files changed outside Neovim

### 🎨 UI Enhancements
- Clean, minimal statusline
- Cursor line and column highlighting
- Kanagawa colorscheme with beautiful Japanese-inspired colors
- Better search highlighting
- Improved completion menu
- Supermaven AI code completion integration

### ⌨️ Efficient Key Mappings

#### Navigation
- `<C-h/j/k/l>` - Navigate between windows
- `<S-h/l>` - Navigate between buffers
- `n/N` - Search with centered results
- `*/#` - Search word under cursor

#### File Operations
- `<leader>w` - Quick save
- `<leader>q` - Quick quit
- `<leader>Q` - Force quit

#### Text Manipulation
- `<leader>a` - Select all text
- `<A-j/k>` - Move lines up/down
- `jj` or `jk` - Quick escape from insert mode
- `<leader>y/p` - Yank/paste to system clipboard

#### Search & Replace
- `<leader>h` - Toggle search highlighting
- `<leader>R` - Quick find and replace

#### Supermaven AI
- `<Tab>` - Accept AI suggestion
- `<C-]>` - Clear AI suggestion
- `<C-l>` - Accept word from AI suggestion
- `<leader>sa` - Start Supermaven
- `<leader>ss` - Stop Supermaven
- `<leader>st` - Toggle Supermaven
- `<leader>sS` - Show Supermaven status
- `<leader>sf` - Switch to free version
- `<leader>sp` - Switch to pro version

#### Treesitter
- `<C-Tab>` - Node incremental selection
- `<S-Tab>` - Node decremental selection
- `<leader>as` - Swap next parameter
- `<leader>aS` - Swap previous parameter

## Keybinding Reference

### **Resolved Conflicts**
The following conflicts have been resolved to ensure smooth operation:

- **`<Tab>`**: Now works with both nvim-cmp and Supermaven (priority to nvim-cmp, then Supermaven)
- **`<leader>a`**: Core "select all" takes precedence over Treesitter parameter swap
- **`<leader>r`**: NvimTree refresh takes precedence over find/replace (moved to `<leader>R`)
- **`<leader>f`**: Telescope mappings take precedence over LSP format (moved to `<leader>lf`)
- **`<C-j>`**: Telescope navigation takes precedence over Supermaven word accept (moved to `<C-l>`)

### **Complete Keybinding List**

#### **Navigation**
- `<C-h/j/k/l>` - Navigate between windows
- `<S-h/l>` - Navigate between buffers
- `n/N` - Search with centered results
- `*/#` - Search word under cursor

#### **File Operations**
- `<leader>w` - Quick save
- `<leader>q` - Quick quit
- `<leader>Q` - Force quit

#### **Text Manipulation**
- `<leader>a` - Select all text
- `<A-j/k>` - Move lines up/down
- `jj` or `jk` - Quick escape from insert mode
- `<leader>y/p` - Yank/paste to system clipboard

#### **Search & Replace**
- `<leader>h` - Toggle search highlighting
- `<leader>R` - Quick find and replace

#### **Supermaven AI**
- `<Tab>` - Accept AI suggestion
- `<C-]>` - Clear AI suggestion
- `<C-l>` - Accept word from AI suggestion
- `<leader>sa` - Start Supermaven
- `<leader>ss` - Stop Supermaven
- `<leader>st` - Toggle Supermaven
- `<leader>sS` - Show Supermaven status
- `<leader>sf` - Switch to free version
- `<leader>sp` - Switch to pro version

#### **Treesitter**
- `<C-Tab>` - Node incremental selection
- `<S-Tab>` - Node decremental selection
- `<leader>as` - Swap next parameter
- `<leader>aS` - Swap previous parameter

#### **Telescope**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `<leader>fc` - Colorscheme
- `<leader>fk` - Keymaps
- `<leader>fs` - Grep string
- `<leader>fd` - Diagnostics
- `<leader>fr` - LSP references
- `<leader>fi` - LSP implementations
- `<leader>fS` - LSP document symbols
- `<leader>fw` - LSP workspace symbols

#### **LSP**
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover
- `<leader>rn` - Rename
- `<leader>ca` - Code action
- `<leader>lf` - Format
- `<leader>d` - Show diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## Installation

1. Clone or copy this configuration to your Neovim config directory:
   ```bash
   # For Linux/macOS
   cp -r . ~/.config/nvim/
   
   # Or if you want to backup your existing config
   mv ~/.config/nvim ~/.config/nvim.backup
   cp -r . ~/.config/nvim/
   ```

2. Start Neovim:
   ```bash
   nvim
   ```

## Performance Tips

### For Even Better Performance
1. **Use a fast terminal**: iTerm2, Alacritty, or Kitty
2. **Enable GPU acceleration** in your terminal
3. **Use a fast font**: JetBrains Mono, Fira Code, or Source Code Pro
4. **Disable antivirus scanning** for your project directories

### Monitoring Performance
Uncomment the performance monitoring section in `init.lua` to profile your Neovim usage:
```lua
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("profile start profile.log")
--     vim.cmd("profile func *")
--     vim.cmd("profile file *")
--   end
-- })
```

## Project Structure

```
nvim/
├── init.lua              # Main entry point
├── lua/
│   ├── core/
│   │   ├── init.lua      # Core module loader
│   │   ├── performance.lua # Performance optimizations
│   │   ├── options.lua   # Editor options and settings
│   │   ├── ui.lua        # UI and colorscheme
│   │   ├── keymaps.lua   # Key mappings
│   │   └── autocmds.lua  # Autocommands and file types
│   └── plugins/
│       ├── init.lua      # Plugin specifications (includes Supermaven)
│       └── lazy.lua      # Lazy.nvim configuration
└── README.md
```

## Customization

### Adding Your Own Settings
Add your custom settings at the end of `init.lua`:

```lua
-- Load core configuration
require("core").setup()

-- Your custom settings here
vim.opt.colorcolumn = "80"
vim.opt.spell = true
vim.opt.spelllang = "en_us"

print("High-performance Neovim configuration loaded!")
```

### File Type Specific Settings
The configuration includes automatic settings for markdown and text files. To add more file types, edit `lua/core/autocmds.lua`:

```lua
-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "python", "javascript" },
  callback = function()
    if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" then
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.textwidth = 80
    elseif vim.bo.filetype == "python" or vim.bo.filetype == "javascript" then
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
    end
  end
})
```

## Troubleshooting

### Slow Startup
- Check if you have other Neovim configurations in `~/.config/nvim/`
- Ensure no other init files are being loaded
- Use `nvim --startuptime startup.log` to profile startup time

### Performance Issues
- Monitor system resources while using Neovim
- Check if any external processes are affecting performance
- Consider using `nvim --clean` to test without any configuration

## Modular Architecture

This configuration uses a modular approach for better organization and maintainability:

### Core Modules (`lua/core/`)
- **`performance.lua`** - Performance optimizations and disabled plugins
- **`options.lua`** - Core editor settings, indentation, search, and file handling
- **`ui.lua`** - UI configuration, colorscheme, and statusline
- **`keymaps.lua`** - All key mappings for navigation and editing
- **`autocmds.lua`** - Autocommands and file type specific settings
- **`init.lua`** - Core module loader that initializes all components

### Plugin Management (`lua/plugins/`)
- **`lazy.lua`** - Lazy.nvim plugin manager configuration
- **`init.lua`** - Plugin specifications and configurations

This structure makes it easy to:
- **Modify specific features** without affecting others
- **Add new functionality** by creating new modules
- **Debug issues** by isolating them to specific modules
- **Share configurations** by copying individual modules
- **Manage plugins** separately from core functionality

## Plugin Management

This configuration includes **Lazy.nvim** as a plugin manager, ready for future plugin installations:

### Adding Plugins
To add plugins, edit `lua/plugins/init.lua`:

```lua
M.plugins = {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "wave", -- wave, dragon, lotus
        transparent = false,
        -- ... more configuration
      })
      vim.cmd.colorscheme "kanagawa"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Telescope configuration
    end,
  },
}
```

### Plugin Management Commands
- `:Lazy` - Open Lazy.nvim UI
- `:Lazy sync` - Install/update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for plugin updates

### Supermaven Commands
- `:SupermavenStart` - Start Supermaven
- `:SupermavenStop` - Stop Supermaven
- `:SupermavenRestart` - Restart Supermaven
- `:SupermavenToggle` - Toggle Supermaven
- `:SupermavenStatus` - Show Supermaven status
- `:SupermavenUseFree` - Switch to free version
- `:SupermavenUsePro` - Switch to pro version
- `:SupermavenLogout` - Log out of Supermaven
- `:SupermavenShowLog` - Show Supermaven logs
- `:SupermavenClearLog` - Clear Supermaven logs

### Performance Considerations
- Plugins are loaded lazily by default
- Disabled version checking and change detection for performance
- Configured with optimal concurrency settings
- Maintains the high-performance core configuration
- Supermaven is integrated with nvim-cmp for seamless completion experience

### Kanagawa Colorscheme
The configuration includes the beautiful **Kanagawa** colorscheme with:
- **Three themes**: `wave` (default), `dragon`, and `lotus`
- **Japanese-inspired colors**: Based on traditional Japanese art
- **Optimized performance**: Fast loading and rendering
- **Custom overrides**: Enhanced search highlighting and UI elements
- **Terminal support**: Full terminal color integration

To switch themes, modify the `theme` option in `lua/plugins/init.lua`:
```lua
theme = "dragon", -- Change to "wave", "dragon", or "lotus"
```

## Why Start Without Plugins?

This configuration prioritizes:
- **Speed**: Minimal plugin loading overhead
- **Reliability**: Carefully selected, stable plugins
- **Simplicity**: Easy to understand and maintain
- **Portability**: Works on any system with Neovim
- **AI Integration**: Supermaven provides intelligent code completion

The built-in Neovim features are powerful enough for most text editing tasks, and this configuration maximizes their potential. Essential plugins like Supermaven for AI completion and Lazy.nvim for plugin management are included while maintaining the performance-first approach.

## License

This configuration is provided as-is for educational and personal use.
