{pkgs, ...}: {
  home.packages = with pkgs; [authy];
}