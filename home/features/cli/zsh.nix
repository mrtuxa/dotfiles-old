{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "sudo nixos-rebuild switch --flake .#$(hostname)";
      };
       oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };
    };
  };
}