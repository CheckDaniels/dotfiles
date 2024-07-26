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
    ];
  };
  programs.tmux.extraConfig = ''
    set -ag terminal-overrides ",xterm-256color:RGB"
    bind -n M-H previous-window
    bind -n M-L next-window
    bind -n M-x "kill-pane; select-layout -E"
    unbind -n M-enter
    unbind -n M-S-q
    unbind -n S-M-q
    unbind -n M-h
    unbind -n M-j
    unbind -n M-k
    unbind -n M-l
    unbind -n M-n
  '';
}
