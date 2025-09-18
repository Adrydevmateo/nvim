# Neovim Configuration | 💫 Fast | 🚀 Intelligent | ⚡️ Powerful

A lightning-fast, AI-powered Neovim configuration designed for modern development workflows. Built with performance in mind and featuring intelligent code completion, this configuration transforms Neovim into a powerful, responsive code editor.

Brought to you by [AdryDev](https://github.com/adrydevmateo)

![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)
![Lua](https://img.shields.io/badge/Lua-5.1+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 🚀 What Makes This Special?

### **Performance First**
- **Lightning Fast**: Optimized startup time under 100ms
- **Memory Efficient**: Minimal memory footprint with smart plugin management
- **Responsive UI**: Smooth animations and instant feedback
- **Optimized Settings**: Fine-tuned for maximum performance

### **AI-Powered Development**
- **Supermaven Integration**: Advanced AI code completion and suggestions
- **Smart Context**: AI understands your codebase and provides relevant suggestions
- **Seamless Workflow**: AI assistance without interrupting your coding flow
- **Pro/Free Support**: Works with both Supermaven versions

### **Developer Experience**
- **Zero Conflicts**: Carefully crafted keybindings with no plugin interference
- **Intelligent Fallbacks**: Smart handling of shared keys like Tab
- **Modern UI**: Beautiful Kanagawa colorscheme with clean aesthetics
- **Responsive Design**: Works perfectly on all screen sizes

## ✨ Key Features

### **Core Optimizations**
- Disabled unnecessary built-in plugins
- Optimized updatetime and timeout settings
- Limited syntax highlighting to first 240 columns
- Reduced memory usage for pattern matching
- No backup or swap files for faster operations

### **Smart Text Editing**
- Intelligent indentation with 2-space tabs
- Relative line numbers for better navigation
- Visual indicators for invisible characters
- Persistent undo across sessions
- Auto-reload files changed outside Neovim

### **Advanced Code Intelligence**
- **LSP Integration**: Full language server protocol support
- **Treesitter**: Advanced syntax parsing and navigation
- **Completion Engine**: Intelligent code completion with snippets
- **Fuzzy Finding**: Lightning-fast file and text search with Telescope

### **File Management**
- **NvimTree**: Modern file explorer with Git integration
- **Terminal Integration**: Built-in terminal with multiple layouts
- **Buffer Management**: Smart buffer navigation and management
- **Project Awareness**: Context-aware file operations

## 🎯 Perfect For

- **Web Developers** building modern applications
- **System Administrators** managing servers and configurations
- **Data Scientists** working with large codebases
- **DevOps Engineers** managing infrastructure as code
- **Students** learning programming and development
- **Anyone** who values speed, efficiency, and AI assistance

## 🚀 Quick Start

### **Prerequisites**
- Neovim 0.9+ installed
- Git for plugin management
- Basic familiarity with Vim/Neovim

### **Installation**
```bash
# Clone the configuration
git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### **First Run**
1. **Wait for setup**: Plugins will install automatically on first run
2. **Configure Supermaven**: Set your API key for AI completion
3. **Start coding**: Everything is ready to use!

## ⌨️ Essential Keybindings

### **Navigation**
- `<C-h/j/k/l>` - Navigate between windows
- `<S-l/h>` - Navigate between buffers
- `<leader>ff` - Find files
- `<leader>fg` - Live grep

### **AI Completion**
- `<C-Tab>` - Accept AI suggestion
- `<C-]>` - Clear AI suggestion
- `<leader>sa` - Start Supermaven

### **Code Intelligence**
- `gd` - Go to definition
- `gr` - Go to references
- `<leader>lf` - Format document
- `<leader>rn` - Rename symbol

### **File Management**
- `<leader>e` - Toggle file explorer
- `<leader>tt` - Toggle terminal
- `<leader>w` - Quick save

## 🔧 Customization

### **Easy Configuration**
All settings are in well-organized Lua files:
- `lua/core/` - Core Neovim settings and keybindings
- `lua/plugins/` - Plugin configurations and keybindings
- `init.lua` - Main entry point

### **Adding Plugins**
Simply add new plugins to `lua/plugins/init.lua`:
```lua
{
    "your-plugin/name",
    config = function()
        -- Your configuration here
    end
}
```

### **Keybinding Customization**
Modify `lua/core/keymaps.lua` to add your own keybindings. The system is designed to prevent conflicts automatically.

## 📚 Documentation

- **Interactive Documentation**: Open `/docs/index.html` in your browser for a complete interactive guide
- **Keybinding System**: See `/docs/KEYBINDING_SYSTEM.md` for comprehensive keybinding documentation
- **Complete Keybinding Reference**: All keybindings organized by category with detailed explanations

### **What's Documented**
- **100+ Keybindings**: Complete reference with conflict-free design
- **8 Categories**: Navigation, Editing, AI, Completion, Treesitter, LSP, Plugins, Terminal
- **Interactive Guide**: Searchable, tabbed interface with examples
- **Conflict Resolution**: Detailed explanation of how conflicts were resolved
- **Plugin Integration**: How all plugins work together harmoniously

## 🐛 Troubleshooting

### **Common Issues**
- **Slow startup**: Check if you have many files in your home directory
- **Plugin errors**: Run `:checkhealth` to diagnose issues
- **Keybinding conflicts**: All conflicts are resolved by default

### **Getting Help**
- Check the interactive documentation
- Review the keybinding system guide
- Open an issue with detailed error information

## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Neovim Team** for the amazing editor
- **Plugin Authors** for their excellent work
- **Supermaven** for AI-powered development
- **Community** for feedback and suggestions

---

**Built with ❤️ for developers who value speed, efficiency, and AI assistance**

*Start coding faster, smarter, and more efficiently with this Neovim configuration.*
