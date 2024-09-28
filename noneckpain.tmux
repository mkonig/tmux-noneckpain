#!/usr/bin/env bash
# vim:ft=sh

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux set-option -g @noneckpain_dir "$CURRENT_DIR"
tmux set-option -g @noneckpain_global_enabled "false"
tmux bind-key z run-shell "$CURRENT_DIR/scripts/tmux_noneckpain.sh local"
tmux bind-key Z run-shell "$CURRENT_DIR/scripts/tmux_noneckpain.sh global"
