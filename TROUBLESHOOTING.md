# Troubleshooting Guide

## Common Issues and Solutions

### 1. Treesitter Parser Installation Errors

**Error**: `Parser not available for language "gitrebase"`

**Solution**: 
- The "gitrebase" parser has been removed from the configuration
- If you encounter similar errors with other parsers, check the [Treesitter parsers list](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
- Remove unsupported parsers from `lua/core/utils.lua`

### 2. Plugin Version Conflicts

**Error**: `You are trying to call the setup function of indent-blankline version 2, but you have version 3 installed`

**Solution**:
1. **Immediate fix**: The indent-blankline plugin has been temporarily disabled in the configuration
2. **Alternative**: Run the cleanup script:
   ```lua
   :lua dofile("cleanup.lua")
   ```
3. **Manual cleanup**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy/indent-blankline.nvim
   rm -rf ~/.local/share/nvim/lazy/lazy.nvim
   ```
4. **Restart Neovim** and run `:Lazy sync`

**To re-enable indent-blankline later**:
- Uncomment the plugin in `lua/plugins/performance.lua`
- Ensure you have the correct version installed

### 3. LSP Server Issues

**Error**: LSP servers not working

**Solutions**:
1. Install language servers:
   ```bash
   # Go
   go install golang.org/x/tools/gopls@latest
   
   # Rust
   rustup component add rust-analyzer
   
   # TypeScript/JavaScript
   npm install -g typescript typescript-language-server
   
   # Python
   pip install python-lsp-server
   ```

2. Check LSP status: `:LspInfo`
3. Check health: `:checkhealth`

### 4. Telescope Issues

**Error**: Telescope extensions not loading

**Solutions**:
1. Install dependencies:
   ```bash
   # For better performance
   sudo pacman -S ripgrep fd
   
   # Or on Ubuntu/Debian
   sudo apt install ripgrep fd-find
   ```

2. Install Telescope extensions:
   ```bash
   # The extensions are already configured, just restart Neovim
   # If issues persist, check :Lazy log
   ```

3. **FZF Extension Issues**:
   - Error: `fzf extension not available`
   - Solution: The telescope-fzf-native.nvim plugin is now properly configured
   - Run `:Lazy sync` to install the plugin
   - Restart Neovim after installation

4. **Test Telescope**: Run `:lua dofile("test_telescope.lua")` to verify everything works

### 5. Performance Issues

**Symptoms**: Slow startup, laggy performance

**Solutions**:
1. Check startup time: `:StartupTime`
2. Disable heavy plugins for large files
3. Check memory usage: `:Lazy stats`
4. Update plugins: `:Lazy sync`

### 6. Missing Icons

**Symptoms**: No icons in file tree, status line, etc.

**Solutions**:
1. Install a Nerd Font:
   ```bash
   # Download and install a Nerd Font from:
   # https://www.nerdfonts.com/font-downloads
   ```

2. Set the font in your terminal or GUI:
   ```bash
   # For terminal
   export FONT="Hack Nerd Font"
   
   # For GUI Neovim, add to your config:
   vim.opt.guifont = "Hack Nerd Font:h12"
   ```

### 7. Git Integration Issues

**Symptoms**: No git signs, git commands not working

**Solutions**:
1. Ensure you're in a git repository
2. Check if git is installed: `git --version`
3. Check gitsigns status: `:Gitsigns status`
4. Restart gitsigns: `:Gitsigns refresh`

### 8. Keymap Issues

**Symptoms**: Keymaps not working

**Solutions**:
1. Check which-key: Press `<leader>` to see available keymaps
2. Check for conflicts: `:verbose map <key>`
3. Reload configuration: `:source $MYVIMRC`

### 9. Plugin Loading Issues

**Symptoms**: Plugins not loading, errors in startup

**Solutions**:
1. Check Lazy log: `:Lazy log`
2. Clean and reinstall: `:Lazy clean` then restart
3. Check plugin health: `:checkhealth`

### 10. NvimTree Configuration Errors

**Error**: `Unknown option: git.show_on_files`

**Solution**:
- The invalid option has been removed from the configuration
- If you see similar errors, check the [nvim-tree documentation](https://github.com/nvim-tree/nvim-tree.lua#setup) for current options
- Run `:Lazy sync` to update the plugin

### 11. Which-Key Issues

**Error**: `There were issues reported with your which-key mappings`

**Solutions**:
1. **Check health**: Run `:checkhealth which-key`
2. **Test configuration**: Run `:lua dofile("test_issues.lua")`
3. **Verify keymaps**: Press `<leader>` to see available keymaps
4. **Check conflicts**: Look for duplicate keymap definitions
5. **Restart Neovim**: Sometimes which-key needs a restart to detect changes

**Common issues**:
- Keymaps not showing descriptions
- Duplicate keymap definitions
- Missing leader key setup
- Plugin loading order issues
- **Keymap conflicts**: Fixed `<leader>tn` and `<leader>tl` conflicts

### 12. Fidget.nvim Issues

**Error**: `Encountered 1 unknown options during setup(). fidget.nvim`

**Solution**:
- The configuration has been updated to use the correct fidget.nvim options
- Changed `window.blend` to `notification.window.winblend`
- Run `:lua dofile("test_issues.lua")` to verify the fix

### 13. Colorscheme Issues

**Symptoms**: Colors not displaying correctly

**Solutions**:
1. Enable true color: Ensure your terminal supports 24-bit color
2. Check terminal colors: `:set termguicolors?`
3. Try different colorschemes: `:colorscheme <name>`

## Debug Commands

Use these commands to diagnose issues:

- `:checkhealth` - Comprehensive health check
- `:Lazy log` - Plugin manager logs
- `:LspInfo` - LSP server information
- `:Telescope diagnostics` - View all diagnostics
- `:StartupTime` - Measure startup time
- `:Lazy stats` - Plugin statistics
- `:verbose map <key>` - Check keymap conflicts

## Getting Help

1. **Check the logs**: Look at `:Lazy log` and `:checkhealth`
2. **Search issues**: Check if your issue is already reported
3. **Minimal config**: Test with a minimal configuration
4. **Update everything**: Run `:Lazy sync` to update all plugins

## Performance Tips

1. **Disable unused plugins**: Comment out plugins you don't use
2. **Use lazy loading**: Ensure plugins load only when needed
3. **Limit file size**: Large files can cause performance issues
4. **Update regularly**: Keep plugins and Neovim updated
5. **Monitor resources**: Use `:Lazy stats` to track plugin usage

## Emergency Recovery

If Neovim becomes unusable:

1. **Safe mode**: Start with `nvim -u NONE`
2. **Reset config**: Backup and remove your config
3. **Clean install**: Remove all plugin directories and reinstall
4. **Minimal setup**: Start with a basic configuration and add features gradually 