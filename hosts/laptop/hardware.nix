# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = ["kvm-amd" "amdgpu"];
    extraModulePackages = [];
    supportedFilesystems = [ "ntfs" ];
  };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8cd02a4e-e5d5-4b1d-880b-a06bf4d2588e";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/4E01-B9F0";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/12c65dfe-7ede-45c1-9126-2941eb5a296a";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0f4u2.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      luks = {
        devices = {
          "luks-913f257d-02cd-499b-bf68-951322dc5a7f".device = "/dev/disk/by-uuid/913f257d-02cd-499b-bf68-951322dc5a7f";
          "luks-913f257d-02cd-499b-bf68-951322dc5a7f".keyFile = "/crypto_keyfile.bin";
          "luks-cfb9783e-e545-48af-959c-46656172136a".device = "/dev/disk/by-uuid/cfb9783e-e545-48af-959c-46656172136a";
        };
      };
      availableKernelModules = ["nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
      secrets = {"/crypto_keyfile.bin" = null;};
    };
  };
}
