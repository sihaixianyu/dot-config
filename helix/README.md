# Personal Config for Helix

> Helix Editor: https://github.com/helix-editor/helix

## Files

| File | Contents |
| --- | --- |
| `config.toml` | Theme, editor options, status line, and shortcuts |
| `languages.toml` | Per-language indentation, language servers, and formatters |
| `themes/` | `fleet_transparent`, `forest_dark`, and `forest_light` |

## Editor

- Theme: `fleet_transparent`, inheriting from `fleet_dark`, with a transparent background and file explorer.
- Relative line numbers, cursor line, color modes, true color, and soft wrap are enabled.
- The file picker includes hidden files; the buffer line appears when multiple buffers are open.
- Completion highlights use theme colors; inline diagnostics and cursor-line blame are enabled.
- LSP inlay hints are enabled and signature help appears below the cursor.
- Old files, commands, and searches persist; clipboard history does not.
- Cursor shapes are bar in insert mode, block in normal mode, and underline in select mode.
- The status line shows mode, version control, diagnostics, file name, position, and file type.

## Shortcuts

| Shortcut | Action |
| --- | --- |
| `Space m` | Preview the current Markdown file in Leaf |
| `Space o` | Choose a file with Yazi and sync its exit directory to Helix's working directory |

## Languages

| Language | Server(s) | Formatter |
| --- | --- | --- |
| C++, CMake | clangd, neocmakelsp | clang-format (C++) |
| Rust | rust-analyzer | built into rust-analyzer |
| Go | gopls | gofmt via gopls |
| Python | pyright + ruff (diagnostics, code actions, format) | ruff |
| Bash | bash-language-server | - |
| JSON | vscode-json-language-server | - |
| TOML | taplo | taplo |

- Configured indentation uses four spaces; JSON has a tab width of two.
- Python servers are configured as `pyright-langserver --stdio` and `ruff server`.
- TOML formatting uses `taplo fmt -`.

## Reloading

- `config.toml` or theme changes: `:config-reload`
- `languages.toml` language-server changes: `:config-reload` then `:lsp-restart` (or restart `hx`)
