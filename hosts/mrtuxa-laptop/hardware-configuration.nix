# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/dc310960-64f2-45b4-98f0-3d71e8b28df9";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-786d0010-4c63-45b7-be88-222023b31edb".device = "/dev/disk/by-uuid/786d0010-4c63-45b7-be88-222023b31edb";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/F270-1264";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c34326eb-01ae-4213-a59b-7f383fb9585f"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0f3u1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

   # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-02ce1833-71f1-4216-a817-217c9a6d0c42".device = "/dev/disk/by-uuid/02ce1833-71f1-4216-a817-217c9a6d0c42";
  boot.initrd.luks.devices."luks-02ce1833-71f1-4216-a817-217c9a6d0c42".keyFile = "/crypto_keyfile.bin";

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };

  services.tlp = {
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  systemd.tmpfiles.rules = map
    (e:
      "w /sys/bus/${e}/power/control - - - - auto"
    ) [
    "pci/devices/0000:00:01.0" # Renoir PCIe Dummy Host Bridge
    "pci/devices/0000:00:02.0" # Renoir PCIe Dummy Host Bridge
    "pci/devices/0000:00:14.0" # FCH SMBus Controller
    "pci/devices/0000:00:14.3" # FCH LPC bridge
    "pci/devices/0000:04:00.0" # FCH SATA Controller [AHCI mode]
    "pci/devices/0000:04:00.1/ata1" # FCH SATA Controller, port 1
    "pci/devices/0000:04:00.1/ata2" # FCH SATA Controller, port 2
    "usb/devices/1-3" # USB camera
  ];

}
