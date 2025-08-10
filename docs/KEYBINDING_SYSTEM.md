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

### **Core Navigation**
```lua
-- Window Navigation
<C-h/j/k/l>     -- Navigate between windows
<S-l/h>         -- Navigate between buffers

-- Search
n/N             -- Search with centered results
*/#             -- Search word under cursor

-- File Operations
<leader>w       -- Quick save
<leader>q       -- Quick quit
<leader>Q       -- Force quit
<leader>R       -- Quick find and replace
```

### **AI Completion (Supermaven)**
```lua
-- AI Suggestion Management
<C-Tab>         -- Accept AI suggestion (conflict-free)
<C-]>           -- Clear AI suggestion
<C-l>           -- Accept word from AI suggestion (conflict-free)

-- Supermaven Control
<leader>sa      -- Start Supermaven
<leader>ss      -- Stop Supermaven
<leader>sr      -- Restart Supermaven
<leader>st      -- Toggle Supermaven
<leader>sS      -- Show Supermaven status
<leader>sf      -- Switch to free version
<leader>sp      -- Switch to pro version
<leader>sl      -- Show Supermaven logs
<leader>sc      -- Clear Supermaven logs
```

### **LSP and Code Intelligence**
```lua
-- Navigation
gd              -- Go to definition
gr              -- Go to references
gi              -- Go to implementation
K               -- Hover documentation

-- Actions
<leader>rn      -- Rename symbol
<leader>ca      -- Code actions
<leader>lf      -- Format document (conflict-free)
<leader>d       -- Show diagnostics

-- Diagnostics
[d              -- Previous diagnostic
]d              -- Next diagnostic

-- LSP Management
<leader>li      -- LSP info
<leader>lr      -- LSP restart
<leader>ls      -- LSP start
<leader>lS      -- LSP stop
```

### **Fuzzy Finding (Telescope)**
```lua
-- File Operations
<leader>ff      -- Find files
<leader>fg      -- Live grep
<leader>fb      -- Buffers
<leader>fh      -- Help tags
<leader>fo      -- Old files
<leader>fc      -- Colorscheme
<leader>fk      -- Keymaps
<leader>fs      -- Grep string
<leader>fd      -- Diagnostics

-- LSP Operations
<leader>fr      -- LSP references
<leader>fi      -- LSP implementations
<leader>fS      -- LSP document symbols
<leader>fw      -- LSP workspace symbols
```

### **File Management (NvimTree)**
```lua
<leader>e       -- Toggle file explorer
<leader>o       -- Focus file explorer
<leader>rf      -- Refresh file explorer (conflict-free)
<leader>n       -- Find current file in tree
```

### **Terminal Management**
```lua
<leader>tt      -- Toggle terminal
<leader>tf      -- Toggle float terminal
<leader>th      -- Toggle horizontal terminal
<leader>tv      -- Toggle vertical terminal

-- Terminal Mode
<Esc>           -- Exit terminal mode
jj              -- Exit terminal mode
jk              -- Exit terminal mode
```

### **Syntax Navigation (Treesitter)**
```lua
-- Incremental Selection
<CR>            -- Init selection
<C-TAB>         -- Node incremental (conflict-free)
<S-TAB>         -- Node decremental (conflict-free)

-- Text Objects
aa              -- Parameter outer
ia              -- Parameter inner
af              -- Function outer
if              -- Function inner
ac              -- Class outer
ic              -- Class inner

-- Movement
]m              -- Next function start
]]              -- Next class start
]M              -- Next function end
][              -- Next class end
[m              -- Previous function start
[[              -- Previous class start
[M              -- Previous function end
[]              -- Previous class end

-- Swap
<leader>as      -- Swap next parameter (conflict-free)
<leader>aS      -- Swap previous parameter (conflict-free)
```

### **Completion and Snippets**
```lua
-- Navigation
<C-p>           -- Previous item
<C-n>           -- Next item
<C-d>           -- Scroll docs up
<C-f>           -- Scroll docs down

-- Actions
<C-Space>       -- Complete
<C-e>           -- Close
<CR>            -- Confirm
<Tab>           -- Next item/expand snippet (with fallback)
<S-Tab>         -- Previous item/jump snippet
```

### **Performance and Utilities**
```lua
-- Syntax
<leader>ps      -- Sync syntax from start
<leader>pc      -- Clear syntax highlighting
<leader>pr      -- Force redraw
<leader>pm      -- Show messages
<leader>pl      -- Stop LSP clients

-- Treesitter
<leader>ts      -- Update parsers
<leader>ti      -- Show installed parsers
```

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
