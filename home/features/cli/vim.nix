{pkgs, ...}: {
  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        vim-tmux-navigator
        vim-surround
        ReplaceWithRegister
        nvim-web-devicons
        lualine-nvim
      ];

      # extra packages like language servers

      extraPackages = with pkgs; [
        nodejs
        lua-language-server
        nil
        nixpkgs-fmt
      ];
  };
}
