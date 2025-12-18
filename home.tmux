#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# When a new session is created, record its "home" directory
tmux set-hook -g session-created \
  "run-shell \"$CURRENT_DIR/scripts/set_session_home.sh\""

# When a new window is created, default its path to the session home
tmux set-hook -g window-created \
  "run-shell \"$CURRENT_DIR/scripts/set_window_home.sh\""

