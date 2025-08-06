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
- Custom color scheme optimized for performance
- Better search highlighting
- Improved completion menu

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
- `<leader>r` - Quick find and replace

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
│   └── core/
│       ├── init.lua      # Core module loader
│       ├── performance.lua # Performance optimizations
│       ├── options.lua   # Editor options and settings
│       ├── ui.lua        # UI and colorscheme
│       ├── keymaps.lua   # Key mappings
│       └── autocmds.lua  # Autocommands and file types
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

- **`lua/core/performance.lua`** - Performance optimizations and disabled plugins
- **`lua/core/options.lua`** - Core editor settings, indentation, search, and file handling
- **`lua/core/ui.lua`** - UI configuration, colorscheme, and statusline
- **`lua/core/keymaps.lua`** - All key mappings for navigation and editing
- **`lua/core/autocmds.lua`** - Autocommands and file type specific settings
- **`lua/core/init.lua`** - Core module loader that initializes all components

This structure makes it easy to:
- **Modify specific features** without affecting others
- **Add new functionality** by creating new modules
- **Debug issues** by isolating them to specific modules
- **Share configurations** by copying individual modules

## Why No Plugins?

This configuration prioritizes:
- **Speed**: No plugin loading overhead
- **Reliability**: No dependency issues
- **Simplicity**: Easy to understand and maintain
- **Portability**: Works on any system with Neovim

The built-in Neovim features are powerful enough for most text editing tasks, and this configuration maximizes their potential.

## License

This configuration is provided as-is for educational and personal use.
