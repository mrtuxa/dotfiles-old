{ programs, ... }: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "cd $HOME/Documents/dotfiles && NIX_ALLOW_UNFREE=1 sudo nixos-rebuild switch --fast --flake .#$(hostname)";
        update = "cd $HOME/dotfiles && nix flake update";
        dotfiles = "cd $HOME/Documents/dotfiles";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      initExtra = ''
        export PATH=$PATH:$HOME/.cargo/bin
        source $HOME/Documents/dotfiles/home/features/cli/scripts/commandnotfound.sh
      '';
    };
  };
}

