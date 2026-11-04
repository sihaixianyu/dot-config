# Personal Config for Helix

> Helix Editor: https://github.com/helix-editor/helix

## Files

| File | Contents |
| --- | --- |
| `config.toml` | editor / UI options, theme selection |
| `languages.toml` | per-language indent, language servers, formatters |
| `themes/` | `forest_dark` (default), `forest_light` |

## Appearance

- Theme: `forest_dark`, as a fixed constant. Adaptive `[theme] light/dark` is not used:
  this build runs the crossterm backend, which neither queries nor parses the terminal
  colour-scheme report (DEC mode 2031), so an adaptive config would always resolve to dark.
  Use `:theme forest_light` to switch manually.
- No italics (`markup.italic` cleared), muted inline-blame colour, picker / popup frame
  colour derived from the `ui.background` foreground.
- Bufferline: only with more than one buffer, no separator glyph.
- Statusline: `separator = "|"`, left = mode / version control / diagnostics / file name +
  modified marker, right = spinner / register / separator / position / percentage / file type.
- Notifications: rounded border (`radius = 2`), drop shadow disabled.
- Editor: relative line numbers, cursorline, color modes, true color, soft wrap,
  hidden files in the file picker, cursor shapes `bar` / `block` / `underline`.

## Languages

| Language | Server(s) | Formatter |
| --- | --- | --- |
| C++, CMake | clangd, neocmakelsp | clang-format (C++) |
| Rust | rust-analyzer | built into rust-analyzer |
| Go | gopls | gofmt via gopls |
| Python | pyright + ruff (lint, code action, format) | ruff |
| Bash | bash-language-server | - |
| JSON | vscode-json-language-server | - |
| TOML | taplo | taplo |

- Indent: 4 spaces for every language except JSON (`tab-width = 2`).
- Python servers come from the project's `uv` virtualenv, so they only resolve when that
  virtualenv is active in the shell that launches `hx`.
- `neocmakelsp` is configured but not installed yet.
- `ruff` runs without `--preview`, so editor lint / format matches a plain `ruff check` /
  `ruff format` in CI.
- No custom keymaps, everything uses the Helix defaults.

## Reloading

- `config.toml` or theme changes: `:config-reload`
- `languages.toml` language-server changes: `:config-reload` then `:lsp-restart`
  (or just restart `hx`)
