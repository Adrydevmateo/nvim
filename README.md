# Neovim Configuration

A modern Neovim configuration with LSP support, Rust development tools, and a beautiful UI.

## Features

- **LSP Support**: Full Language Server Protocol support with Mason for easy installation
- **Rust Support**: Rust-specific tools including rust-analyzer and rust-tools
- **Telescope**: Fuzzy finder for files, grep, and more
- **Treesitter**: Advanced syntax highlighting and code parsing
- **Toggleterm**: Integrated terminal
- **NvimTree**: File explorer
- **Kanagawa**: Beautiful colorscheme
- **Lazy**: Fast plugin manager
- **Lua**: Written entirely in Lua

## Keybindings

### General
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>Q` - Quit all
- `<leader>h` - Clear search highlights

### Window Management
- `<C-h/j/k/l>` - Navigate between windows
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally

### Buffer Management
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer
- `<leader>bd` - Delete buffer

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover
- `<leader>ca` - Code actions
- `<leader>rn` - Rename

### Terminal
- `<leader>tt` - Toggle terminal
- `<C-\>` - Toggle terminal (alternative)

### File Explorer
- `<leader>e` - Toggle NvimTree
- `<leader>o` - Focus NvimTree

### Comments
- `<leader>cc` - Toggle line comment
- `<leader>cb` - Toggle block comment

## Installation

1. Clone this repository to your Neovim config directory:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

2. Install Neovim (version 0.8.0 or higher)

3. Start Neovim and wait for plugins to install:
   ```bash
   nvim
   ```

## Plugin Manager

This configuration uses [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. It will be automatically installed on first run.

## LSP Setup

The configuration includes Mason for easy LSP installation. Supported languages include:
- Lua
- Rust
- C/C++
- Python
- TypeScript/JavaScript
- Go

LSP servers will be automatically installed when you open files of the corresponding language.

## Rust Development

For Rust development, the configuration includes:
- rust-analyzer for LSP
- rust-tools for enhanced Rust support
- crates.nvim for Cargo.toml management

## Colorscheme

The configuration uses the Kanagawa colorscheme with the "wave" theme by default.

## File Structure

```
nvim/
├── init.lua              # Main entry point
├── lua/
│   ├── core/             # Core configuration
│   │   ├── options.lua   # Neovim options
│   │   ├── keymaps.lua   # Keybindings
│   │   ├── lazy.lua      # Plugin manager config
│   │   ├── utils.lua     # Utility functions
│   │   └── startup.lua   # Startup configuration
│   └── plugins/          # Plugin configurations
│       ├── init.lua      # Plugin loader
│       ├── colorscheme.lua
│       ├── lsp.lua
│       ├── rust.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── toggleterm.lua
│       ├── nvimtree.lua
│       ├── editor.lua
│       └── utility.lua
└── README.md
```

## Requirements

- Neovim 0.8.0 or higher
- Git
- A C compiler (for some plugins)
- ripgrep (for Telescope live grep)

## Troubleshooting

If you encounter issues:

1. Make sure you have Neovim 0.8.0 or higher
2. Check that all dependencies are installed
3. Run `:checkhealth` in Neovim to see detailed information
4. Check the logs with `:Lazy log`

## Contributing

Feel free to submit issues and enhancement requests! 