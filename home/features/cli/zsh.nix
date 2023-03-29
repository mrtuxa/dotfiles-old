_: {
    programs.zsh = {
        enable = true;
        history = {
            size = 10000;
        };
        oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
        };
        shellAliases = {
            rebuild-conf = "cd /home/mrtuxa/Documents/dotfiles && sudo nixos-rebuild switch --flake .#$(hostname)";
            dotfiles-push = "git add . && git commit -m 'automatic push' && git push origin master";
        };
    };
}