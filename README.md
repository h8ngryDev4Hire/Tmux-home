 # tmux-session-home

 QoL tmux plugin that gives each session a "home" directory and makes it easy
 for your shell to go back there with plain `cd`.

 ## Installation (TPM)

 Add to your `~/.tmux.conf`:

 ```
 set -g @plugin 'yourusername/tmux-session-home'
 run '~/.tmux/plugins/tpm/tpm'
 ```

 Then inside tmux, press `prefix + I` to install.

 ## Shell integration

 Add this to your shell rc (bash/zsh) to make bare `cd` go to the session home
 when inside tmux:

 ```
 _tmux_real_cd() {
   builtin cd "$@"
 }
 cd() {
 If arguments given, behave normally
   if [ "$#" -ne 0 ]; then
     _tmux_real_cd "$@"
     return
   fi
 Outside tmux, behave normally
   if [ -z "$TMUX" ]; then
     _tmux_real_cd
     return
   fi
 Inside tmux, try session home
   local session_name var_name session_home
   session_name="$(tmux display -p -F "#{session_name}" 2>/dev/null)" || {
     _tmux_real_cd
     return
   }
 var_name="TMUX_SESSION_HOME_${session_name}"
   session_home="$(
     tmux show-environment -g "$var_name" 2>/dev/null | sed 's/^[^=]*=//'
   )"
 if [ -n "$session_home" ] && [ -d "$session_home" ]; then
     _tmux_real_cd "$session_home"
   else
     _tmux_real_cd
   fi
 }
 ```
