{ config, lib, pkgs, ... }:
with lib;
{
  config = {
    # packages
    environment.systemPackages = with pkgs; [
      # Back up and restore files.
      borgbackup
      fd
      fzf
      git
      gnupg
      htop
      neovim
      # Partition Management
      parted
      pass
      # File navigation
      ranger
      ripgrep
      sudo
      tmux
      vim
      yadm
    ];

    # shells
    programs.bash.enableCompletion = true;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };

    programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  };
}
