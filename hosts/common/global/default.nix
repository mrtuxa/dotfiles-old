{outputs, ...}: {
  imports = [./nix.nix];

  nixpkgs = {
    config = {allowUnfree = true;};
  };
}