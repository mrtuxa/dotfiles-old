{pkgs, ...}:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ../../features/direnv.nix
    ../../features/utils.nix
    ../../features/vim.nix
  ];

  home.packages = with pkgs; [
    # common tools
    ripgrep # better grep
    fd # better find
    ncdu # tui disk usage utility
    duf # better df
    libqalculate # calculator
    killall
    wget
    tree

    # dev
    gnumake
    gcc
    pkg-config
    httpie

    # nix tools
    nix-index
    alejandra
    deadnix
    statix
  ];
}