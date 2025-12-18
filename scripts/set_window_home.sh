#!/usr/bin/env bash

session_name="$(tmux display -p -F "#{session_name}")"
var_name="TMUX_SESSION_HOME_${session_name}"

session_home="$(
  tmux show-environment -g "$var_name" 2>/dev/null | sed 's/^[^=]*=//'
)"

[ -z "$session_home" ] && exit 0

# Set the window's default-path so new panes/commands start there
tmux set-option -t "#{window_id}" default-path "$session_home"

