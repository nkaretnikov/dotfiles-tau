# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ata_piix" "firewire_ohci" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  # Nonfree software:
  # boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5bb6c937-6648-4dee-87ac-076889f30734";
      fsType = "ext3";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DBD7-4410";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = 4;
}
