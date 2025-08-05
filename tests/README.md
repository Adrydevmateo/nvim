# Neovim Configuration Tests

This directory contains test scripts to verify that various components of the Neovim configuration are working correctly.

## Test Scripts

### Core Functionality Tests

- **`test_issues.lua`** - Comprehensive test for which-key and fidget issues
  - Tests which-key configuration and keymap conflicts
  - Tests fidget.nvim configuration
  - Provides health checks and troubleshooting suggestions

- **`test_treesitter.lua`** - Treesitter parser configuration test
  - Verifies Treesitter installation and configuration
  - Tests JSX/TSX support (handled by javascript/typescript parsers)
  - Checks for invalid parser configurations

### Plugin-Specific Tests

- **`test_telescope.lua`** - Basic Telescope functionality test
  - Tests Telescope loading and basic functions
  - Verifies keymap registration
  - Checks dependency availability (ripgrep, fd)

- **`test_telescope_commands.lua`** - Telescope command availability test
  - Tests Telescope user commands (`:Telescope`)
  - Verifies all keymaps are registered
  - Tests builtin functions availability

- **`test_react_telescope.lua`** - React/Vite specific Telescope test
  - Tests Telescope in React/Vite project context
  - Verifies file detection for React/Vite projects
  - Checks project structure and dependencies

- **`test_whichkey.lua`** - Which-key configuration test
  - Tests which-key loading and setup
  - Verifies keymap registration
  - Checks for configuration conflicts

- **`test_nvimtree.lua`** - NvimTree configuration test
  - Tests NvimTree loading and API availability
  - Verifies basic functionality
  - Checks for configuration issues

### Utility Scripts

- **`cleanup.lua`** - Configuration cleanup script
  - Cleans plugin cache and reinstalls plugins
  - Resets problematic plugin configurations
  - Provides troubleshooting steps

## Usage

Run any test script in Neovim with:

```vim
:lua dofile("tests/test_name.lua")
```

## Common Test Commands

```vim
" Test all core functionality
:lua dofile("tests/test_issues.lua")

" Test Treesitter configuration
:lua dofile("tests/test_treesitter.lua")

" Test Telescope in React/Vite projects
:lua dofile("tests/test_react_telescope.lua")

" Test Telescope commands
:lua dofile("tests/test_telescope_commands.lua")

" Clean up configuration issues
:lua dofile("tests/cleanup.lua")
```

## Troubleshooting

If tests fail:

1. **Restart Neovim** to apply configuration changes
2. **Run cleanup script**: `:lua dofile("tests/cleanup.lua")`
3. **Check plugin health**: `:checkhealth`
4. **Update plugins**: `:Lazy sync`
5. **Check logs**: `:Lazy log`

## Test Results

Each test script provides:
- ✅ Success indicators for working components
- ❌ Error indicators for failed components
- 🔧 Troubleshooting suggestions
- 📝 Next steps for resolution

## Adding New Tests

When adding new test scripts:

1. Follow the naming convention: `test_component.lua`
2. Include a header comment with usage instructions
3. Provide clear success/failure indicators
4. Include troubleshooting suggestions
5. Update this README with the new test description 