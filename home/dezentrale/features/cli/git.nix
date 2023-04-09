{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "dezentrale";
    userEmail = "mrtuxa@leipzig.freifunk.net";
    lfs = {enable = true;};
  };
}