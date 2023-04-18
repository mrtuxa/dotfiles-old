{pkgs, ...}: {
  home.packages = with pkgs; [
    teamspeak_client
  ];
}