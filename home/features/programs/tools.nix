{pkgs, ...}: {
  home.packages = with pkgs; [
    wofi
    grim
    obs-studio
    neofetch
  ];
}
