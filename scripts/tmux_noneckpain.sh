#!/usr/bin/env bash

change_level="$1"

noneckpain_enabled=$(tmux show-option -wqv @noneckpain_enabled)
noneckpain_global_enabled=$(tmux show-option -gv @noneckpain_global_enabled)
noneckpain_pane_color=$(tmux show-option -gv @noneckpain_pane_color)
scripts_dir="$(tmux show-option -gv @noneckpain_dir)/scripts"

function local_hooks() {
    local mode="$1"
    local options="-w"

    if [[ "$mode" == "off" ]]; then
        options="-wu"
    fi

    tmux set-hook ${options} after-split-window "source-file ${scripts_dir}/noneckpain.conf"
    tmux set-hook ${options} pane-exited "source-file ${scripts_dir}/noneckpain.conf"
}

function global_hooks() {
    local mode="$1"
    local options="-g"

    if [[ "$mode" == "off" ]]; then
        options="-gu"
    fi

    tmux set-hook ${options} after-new-window "source-file ${scripts_dir}/noneckpain.conf"
}

function add_side_pane() {
    tmux split-window -h -b ''
    tmux select-pane -t 0 -P "fg=${noneckpain_pane_color},bg=${noneckpain_pane_color}"
    tmux resize-pane -t 0 -x 50
    tmux select-pane -t 1
}

function remove_side_pane() {
    tmux kill-pane -t0
}

if [[ "$change_level" == "global" ]]; then
    if [[ "$noneckpain_global_enabled" == "true" ]]; then
        local_hooks off
        global_hooks off
        remove_side_pane
        tmux set-option -g @noneckpain_global_enabled "false"
        tmux set-option -w @noneckpain_enabled "false"
    else
        if [[ ! "$noneckpain_enabled" == "true" ]]; then
            add_side_pane
            local_hooks on
        fi
        global_hooks on
        tmux set-option -g @noneckpain_global_enabled "true"
        tmux set-option -w @noneckpain_enabled "true"
    fi
else
    if [[ "$noneckpain_enabled" == "true" ]]; then
        local_hooks off
        tmux kill-pane -t0
        tmux set-option -w @noneckpain_enabled "false"
    else
        add_side_pane
        local_hooks on
        tmux set-option -w @noneckpain_enabled "true"
    fi
fi
