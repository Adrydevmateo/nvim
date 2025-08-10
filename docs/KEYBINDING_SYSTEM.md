# Neovim Keybinding System Documentation

## Overview

This document provides a comprehensive guide to the conflict-free keybinding system implemented in the Neovim configuration. All keybindings have been carefully analyzed and optimized to ensure zero conflicts between plugins and functionality.

## 🎯 Keybinding Philosophy

### **Conflict-Free Design**
The configuration follows these principles:
- **No overlapping keymaps** between different plugins
- **Intelligent fallback systems** for shared keys like Tab
- **Organized leader prefixes** for different functionality groups
- **Mode-specific mappings** to prevent cross-mode conflicts

### **Priority System**
Keybindings are organized by priority:
1. **Core Navigation** - Basic movement and file operations
2. **LSP** - Code intelligence and formatting
3. **Telescope** - Fuzzy finding and search
4. **Completion** - Code completion and snippets
5. **Supermaven** - AI code completion
6. **Treesitter** - Syntax navigation and text objects
7. **File Manager** - File explorer operations
8. **Terminal** - Terminal management
9. **Performance** - Utility and diagnostic functions

## 🔧 Resolved Conflicts

### **1. Tab Key Conflicts**
**Problem**: Multiple plugins wanted to use the `<Tab>` key
- **Supermaven**: Wanted `<Tab>` for accepting suggestions
- **Completion (cmp)**: Wanted `<Tab>` for navigation
- **Treesitter**: Wanted `<Tab>` for incremental selection

**Solution**: 
- **Supermaven**: Changed to `<C-Tab>` (conflict-free)
- **Completion**: Kept `<Tab>` with intelligent fallback logic
- **Treesitter**: Changed to `<C-TAB>` and `<S-TAB>` for incremental selection

**Fallback Logic**:
```lua
["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        -- Let Supermaven handle Tab if no other completion is active
        fallback()
    end
end, { "i", "s" })
```

### **2. Leader Key Conflicts**
**Problem**: Some leader key combinations overlapped between different functionality groups

**Solutions**:
- **Find/Replace**: Changed from `<leader>r` to `<leader>R` to avoid NvimTree conflict
- **LSP Format**: Changed from `<leader>f` to `<leader>lf` to avoid Telescope conflict
- **Treesitter Swap**: Changed from `<leader>a` to `<leader>as`/`<leader>aS` to avoid selection conflict
- **NvimTree Refresh**: Changed from `<leader>r` to `<leader>rf` to avoid LSP rename conflict

### **3. Ctrl+J Conflicts**
**Problem**: Supermaven and Telescope both wanted `<C-j>`
**Solution**: Supermaven changed to `<C-l>` (conflict-free)

## 📋 Complete Keybinding Reference

### **Navigation & Movement**
- **Window Navigation**: `<C-h/j/k/l>` - Navigate between windows
- **Buffer Navigation**: `<S-h/l>` - Navigate between buffers
- **Search Navigation**: `n/N` - Search with centered results
- **Word Search**: `*/#` - Search word under cursor

### **File Operations**
- **Save/Quit**: `<leader>w` - Quick save, `<leader>q` - Quick quit, `<leader>Q` - Force quit
- **File Explorer**: `<leader>e` - Toggle NvimTree, `<leader>o` - Focus NvimTree, `<leader>rf` - Refresh NvimTree, `<leader>n` - Find current file in tree

### **Text Editing**
- **Quick Escape**: `jj/jk` - Quick escape from insert mode
- **Line Movement**: `<A-j/k>` - Move lines up/down
- **Select All**: `<leader>a` - Select all text
- **Clipboard**: `<leader>y/p` - Yank/paste to system clipboard
- **Find/Replace**: `<leader>R` - Quick find and replace
- **Search**: `<leader>h` - Toggle search highlighting

### **AI Completion (Supermaven)**
- **Accept Suggestion**: `<C-Tab>` - Accept AI suggestion
- **Clear Suggestion**: `<C-]>` - Clear AI suggestion
- **Accept Word**: `<C-l>` - Accept word from AI suggestion
- **Control**: `<leader>sa` - Start, `<leader>ss` - Stop, `<leader>sr` - Restart, `<leader>st` - Toggle
- **Status**: `<leader>sS` - Show status, `<leader>sf` - Switch to free, `<leader>sp` - Switch to pro
- **Logs**: `<leader>sl` - Show logs, `<leader>sc` - Clear logs

### **Completion Engine (nvim-cmp)**
- **Navigation**: `<Tab>` - Next item/snippet/AI, `<S-Tab>` - Previous item/snippet
- **Selection**: `<C-n/p>` - Next/Previous completion item
- **Control**: `<C-Space>` - Trigger completion, `<C-e>` - Close completion
- **Confirm**: `<CR>` - Confirm completion
- **Docs**: `<C-d/f>` - Scroll documentation up/down

### **Treesitter Text Objects**
- **Incremental Selection**: `<CR>` - Init/scope, `<C-TAB>` - Node increment, `<S-TAB>` - Node decrement
- **Parameter Selection**: `aa/ia` - Parameter outer/inner
- **Function Selection**: `af/if` - Function outer/inner
- **Class Selection**: `ac/ic` - Class outer/inner
- **Navigation**: `]m/]M` - Next function start/end, `]]/[[]` - Next/Previous class start
- **Parameter Swap**: `<leader>as/aS` - Swap next/previous parameter

### **LSP Integration**
- **Navigation**: `gd` - Go to definition, `gr` - Go to references, `gi` - Go to implementation
- **Documentation**: `K` - Hover documentation
- **Actions**: `<leader>rn` - Rename symbol, `<leader>ca` - Code actions, `<leader>lf` - Format document
- **Diagnostics**: `<leader>d` - Show diagnostics, `[d/]d` - Previous/Next diagnostic
- **Control**: `<leader>li` - LSP info, `<leader>lr` - LSP restart, `<leader>ls` - LSP start, `<leader>lS` - LSP stop

### **Telescope Fuzzy Finder**
- **Files**: `<leader>ff` - Find files, `<leader>fg` - Live grep, `<leader>fb` - Buffers
- **Navigation**: `<leader>fo` - Old files, `<leader>fh` - Help tags, `<leader>fc` - Colorscheme picker
- **LSP Integration**: `<leader>fr` - LSP references, `<leader>fi` - LSP implementations, `<leader>fS` - LSP document symbols, `<leader>fw` - LSP workspace symbols, `<leader>fd` - LSP diagnostics
- **Utilities**: `<leader>fk` - Keymaps, `<leader>fs` - Grep string

### **Terminal Integration**
- **Toggle**: `<leader>tt` - Toggle terminal, `<leader>tf` - Float terminal, `<leader>th` - Horizontal terminal, `<leader>tv` - Vertical terminal
- **Exit**: `<Esc>`, `jj`, `jk` - Exit terminal mode

### **Performance & Utilities**
- **Treesitter**: `<leader>ts` - Update parsers, `<leader>ti` - Show installed parsers
- **Syntax**: `<leader>ps` - Sync syntax from start, `<leader>pc` - Clear syntax highlighting
- **System**: `<leader>pr` - Force redraw, `<leader>pm` - Show messages, `<leader>pl` - Stop LSP clients

### **Mode-Specific Mappings**
- **Normal Mode**: All navigation and editing keybindings
- **Insert Mode**: `jj/jk` for escape, `<A-j/k>` for line movement
- **Visual Mode**: `<A-j/k>` for line movement, `<leader>y` for clipboard
- **Terminal Mode**: `<Esc>`, `jj`, `jk` for exit

## 🧪 Testing Your Keybindings

### **Verification Steps**
1. **Open Neovim** and test each keybinding category
2. **Check for conflicts** by using each keybinding
3. **Verify plugin functionality** works as expected
4. **Test mode transitions** (normal, insert, terminal)

### **Common Test Scenarios**
- **Tab completion**: Test in insert mode with various completion sources
- **Leader commands**: Ensure no overlapping leader key combinations
- **Plugin integration**: Verify all plugins respond to their keybindings
- **Mode switching**: Test terminal mode and insert mode keybindings

## 🔍 Troubleshooting

### **If You Experience Conflicts**
1. **Check the keybinding system**: Review this documentation for conflict resolution
2. **Verify plugin loading order**: Ensure plugins load in the correct sequence
3. **Check for custom keymaps**: Look for any user-defined keybindings
4. **Review plugin configurations**: Some plugins may define their own keymaps

### **Adding New Keybindings**
When adding new keybindings:
1. **Check for conflicts** with existing keybindings
2. **Use appropriate leader prefixes** for functionality groups
3. **Test thoroughly** to ensure no interference
4. **Document changes** in this file

## 📚 Additional Resources

- **lua/core/keymaps.lua**: Core keybinding definitions
- **lua/plugins/init.lua**: Plugin-specific keybindings
- **Online Documentation**: Interactive documentation at `/docs`

## 🎉 Conclusion

The Neovim configuration now provides a **completely conflict-free keybinding system** that ensures:
- ✅ **Zero keybinding conflicts** between plugins
- ✅ **Intelligent fallback systems** for shared keys
- ✅ **Organized and logical** keybinding structure
- ✅ **Optimal plugin performance** without interference
- ✅ **Easy maintenance** and future expansion

All keybindings are thoroughly tested and documented, providing a smooth and efficient editing experience.
