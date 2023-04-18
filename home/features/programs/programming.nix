{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    yarn
    python3
    unzip
    php
  ];
}

