{ config, pkgs, ...}:

{
  programs.tmux.enable = true;
  programs.tmux = {
    aggressiveResize = true;
    mouse = true;
    escapeTime = 0;
    baseIndex = 1;
    clock24 = true;
    newSession = true;
    keyMode = "vi";
    prefix = "M-Space";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.nord
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set -g @tilish-default 'main-vertical'
        '';
      }
      tmuxPlugins.yank
    ];
  };
    # set -ag terminal-overrides ",xterm-256color:RGB"
  programs.tmux.extraConfig = ''
    set -g pane-active-border-style "bg=default fg=#${config.colorScheme.palette.base05}"
    bind -n M-x "kill-pane; select-layout; select-layout -E"
    unbind -n M-enter
    unbind -n M-Q
    unbind -n M-h
    unbind -n M-j
    unbind -n M-k
    unbind -n M-l
    unbind -n M-n
    unbind -n M-S
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    bind -n C-M-Space copy-mode
    bind-key -n M-h previous-window
    bind-key -n M-l next-window
    bind-key -n M-S run-shell -b "sh ~/.config/tmux/tmux-switch-session.sh"
  '';
}
