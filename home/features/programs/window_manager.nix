{pkgs, ...}: {
  home.packages = with pkgs; [
    alacritty
    swaybg
    waybar
  ];
}
