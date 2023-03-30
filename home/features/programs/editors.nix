{pkgs, ...}: {
  home.packages = with pkgs; [
    vscodium
    helix
    jetbrains.idea-ultimate
  ];
}
