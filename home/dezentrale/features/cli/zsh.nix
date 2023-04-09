{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "cd /home/dezentrale/Documents/dotfiles && NIX_ALLOW_UNFREE=1 sudo nixos-rebuild switch --flake .#$(hostname)";
        dotfiles = "cd /home/dezentrale/Documents/dotfiles";
      };
       oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };
    };
  };
}