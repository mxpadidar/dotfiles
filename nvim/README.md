# Neovim

Requires Neovim 0.12+. The repository installer includes the supporting CLI tools.

Python uses ty for types and navigation, Ruff for linting and formatting.
Go uses gopls for language features, import organization, and formatting.
JSON, YAML, TOML, Lua, shell, and the existing web/template servers are
included. Mason installs configured tools on first interactive startup. Restart
Neovim after installation. Old Pyright installations are not enabled.

## Everyday keys

Space is the leader. Pause after a prefix for Which-key, or use `Space fk`
to search mappings.

- `-`: open Yazi. Backspace: close the current pane in normal mode.
- `Alt+Enter`: vertical split. `Alt+h/j/k/l`: focus a pane.
- `Alt+=` / `Alt+-`: widen/narrow. `Alt+f`: maximize width. `Alt+n`: equalize.
- `Alt+Shift+j/k`: move a line or selection down/up.
- `Ctrl+s`: save. `Space bd`: close the buffer while keeping the pane.
- `Space bn/bp`: next/previous buffer. `Space t`: toggle the terminal.
- `Space ff/fg/fb`: find files, search project text, select buffers.
- `Space fs/fS`: file/workspace symbols. `Space fh`: help.
- `gd`: definition in a split. `grr/gri/grt`: references, implementations, type.
- `K`: documentation. `Space cr/ca/cf`: rename, code action, format.
- `Space cd`: diagnostic at cursor. `[d` / `]d`: previous/next diagnostic.
- `Space fd/fD`: file/workspace diagnostics. `Space cl`: restart LSPs.
- `Space gg`: LazyGit. `[h` / `]h`: previous/next changed hunk.
- `Space gp/gs`: preview/stage hunk. `Space gb/gB`: file/line blame.
- `Space ac/at`: Copilot Chat / toggle automatic suggestions.
- `Space ml/mb`: follow Markdown link / return to previous file.
- `za/zo/zc/zR/zM`: toggle/open/close folds. `zN`: toggle nested folds.

Alt pane navigation also works in insert mode and embedded terminals.
Backspace still deletes text there. Use `Ctrl+\`, then `Ctrl+n`, to leave
terminal input mode; Escape is passed to the terminal application.

## Editing and completion

- `saiw"`: surround a word with quotes. `sd"`: remove quotes.
- `sr"'`: replace double quotes with single quotes.
- `vaf`: select a function. `cif`: change its body.
- `aa/ia`: argument objects; `ac/ic`: class objects where supported.
- `[f` / `]f`: previous/next function. `Space c<` / `Space c>`: swap arguments.
- `Ctrl+n/p`: completion choices. `Ctrl+y`: accept. `Ctrl+e`: dismiss menu.
- Tab / Shift+Tab: snippet fields. Enter remains a newline.
- `Alt+y`: accept AI suggestion. `Alt+;`: accept a word. `Alt+e`: dismiss.

Zsh uses the same Alt suggestion controls. Its completion menu uses Ctrl+n/p
and Enter to select.
Hyprland uses Super+Enter for a terminal, Super+- for Yazi, and
Super+Backspace to close a window. Existing Super+E and Super+Q bindings remain.

## Appearance and maintenance

Tokyo Night uses the palette from `ghostty/themes/tokyo-night-enhanced`,
including matching embedded-terminal ANSI colors. Editor and embedded-terminal
backgrounds inherit Ghostty's 0.85 opacity and Hyprland's blur. Menus,
diagnostic popups, and selections retain solid backgrounds for readability.

Use `:checkhealth vim.lsp`, `:Mason`, and `:ConformInfo` to inspect tools.
Keep Python dependencies in the project's `.venv` and Go projects under their
`go.mod` or `go.work`. Formatting follows each project's tool configuration.
Prettier needs the project's Astro plugin when formatting Astro files.

Plugin revisions are tracked in `nvim-pack-lock.json`. Update plugins with
`:lua vim.pack.update()`. After Tree-sitter updates, run `:TSUpdate` and restart.
Removed plugins may remain on disk but are no longer loaded.
Neotest is deferred.
