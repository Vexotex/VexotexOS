{ self, inputs, ... }: {

    flake.nixosModules.RobertLaptopHardware = { config, lib, pkgs, modulesPath, ... }: {
        imports = [ 
            (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" =
            { device = "/dev/disk/by-uuid/58b39b1f-bf67-4bcf-8c70-30ff6557f1ed";
            fsType = "ext4";
            };

        fileSystems."/boot" =
            { device = "/dev/disk/by-uuid/A4A1-82EC";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
            };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}