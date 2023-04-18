{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.clion 
    jetbrains.webstorm 
    jetbrains.idea-ultimate
    jetbrains.phpstorm
  ];
}