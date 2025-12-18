#!/usr/bin/env bash

# Directory of the client that created the session
client_cwd="$(tmux display -p -F "#{client_cwd}")"
session_name="$(tmux display -p -F "#{session_name}")"

# Store as a per-session env var
var_name="TMUX_SESSION_HOME_${session_name}"
tmux set-environment -g "$var_name" "$client_cwd"

