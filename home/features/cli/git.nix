{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "mrtuxa";
    userEmail = "mrtuxa@leipzig.freifunk.net";
    lfs = {enable = true;};
  };
}