# watson status

Displays information about the current watson status

## How to install

Installation with Tmux Plugin Manager (recommended).

Add plugin to the list of TPM plugins in `.tmux.conf`:

`set -g @plugin 'gish/tmux-watson-status'`

## How to use

Add `#{watson_status}` to your status bar config in `.tmux.conf`.

Example `set -g status-right '🕙 %H:%M #{watson_status}'`
