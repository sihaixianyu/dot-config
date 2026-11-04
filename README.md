# dot-config

My `~/.config` — themes are tuned for transparent, low-saturation backgrounds.

| Path | App | Notes |
| --- | --- | --- |
| `ghostty/config` | [Ghostty](https://ghostty.org) | font, transparency + blur, cursor |
| `helix/` | [Helix](https://github.com/helix-editor/helix) | see [`helix/README.md`](helix/README.md) |
| `leaf/` | leaf | theme + UI options |
| `herdr/config.toml` | herdr | theme, sidebar width, prefix keys |
| `sheldon/plugins.toml` | [sheldon](https://github.com/rossmacarthur/sheldon) | zsh plugin manager |
| `starship.toml` | [Starship](https://starship.rs) | prompt format, palette |

## Shared theme

`fleet_transparent` is the common theme, kept in sync between Helix and leaf:

- `helix/themes/fleet_transparent.toml`
- `leaf/themes/fleet_transparent.toml`

Both pair with a translucent terminal, so panel and selection backgrounds are
deliberately semi-transparent rather than solid.

## Not tracked

Runtime state is ignored on purpose (`.gitignore`): herdr session snapshots,
sockets, logs, plugin checkouts, and local `*.bak.*` files.
