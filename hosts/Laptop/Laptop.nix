{ self, inputs, ... }: {

    flake.nixosConfigurations.Laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.LaptopHardware
        self.nixosModules.LaptopConfiguration
        self.nixosModules.UserVexotex
        self.nixosModules.Networking
        self.nixosModules.Languages
        self.nixosModules.Pipewire
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
      ];
    };
}