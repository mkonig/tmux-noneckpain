# noneckpain.tmux

Small tmux plugin that creates a black pane to the left side if only a single
pane exists. Similar to [no-neck-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim)
its purpose is to not have to look way to the left when working on a single
command line.

### Key bindings

- `prefix + z` - toggle noneckpain in current window
- `prefix + Z` - toggle noneckpain in current session

Enabling it in current session will not alter existing windows but the current
and newly created ones.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'mkonig/tmux-noneckpain'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Configuration

The color of the pane can be changed with:

    set -g @noneckpain_pane_color "#000000"
