{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
    extraConfig = ''
      bind ^C new-window -c "#{pane_current_path}"
      bind ^D detach

      bind H previous-window
      bind L next-window

      bind N command-prompt -p "New Session:" "new-session -A -s '%%'"
      bind r command-prompt "rename-window %%"
      bind R source-file ~/.config/tmux/tmux.conf
      bind ^A last-window
      bind w list-windows
      bind z resize-pane -Z
      bind ^L refresh-client
      bind l refresh-client
      bind | split-window
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind -r -T prefix , resize-pane -L 20
      bind -r -T prefix . resize-pane -R 20
      bind -r -T prefix - resize-pane -D 7
      bind -r -T prefix = resize-pane -U 7
      bind x swap-pane -D
      bind s choose-session
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
      bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+


      set -sg terminal-overrides ",*:RGB"

      set -g prefix ^A
      set -g base-index 1
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 1000000
      set -g renumber-windows on
      bind Space last-window
      set -g set-clipboard on
      setw -g mode-keys vi
      set -g pane-active-border-style 'fg=blue,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'
      set -g mouse on
      set -g status-bg "#333333"
      set-window-option -g status-left " [#S] "
      set-option -g status-left-length 50

      set -g status-style 'bg=#333333 fg=#5eacd3'


      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-yank'

      bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"

      run '~/.tmux/plugins/tpm/tpm'

    '';
  };
}
