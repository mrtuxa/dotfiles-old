{ programs, ... }: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "cd /home/$(user)/Documents/dotfiles && NIX_ALLOW_UNFREE=1 sudo nixos-rebuild switch --flake .#$(hostname)";
        update = "cd /home/$(user)/Documents/dotfiles && nix flake update";
        dotfiles = "cd /home/$(user)/Documents/dotfiles";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };
}

