{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode
    helix
    jetbrains.idea-ultimate
  ];
}
