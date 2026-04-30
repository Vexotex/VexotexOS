{ self, inputs, ... }: {

    flake.nixosConfigurations.RobertLaptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.RobertLaptopHardware
        self.nixosModules.RobertLaptopConfiguration
        self.nixosModules.UserLordHase # Benutzer
        self.nixosModules.Networking # Internet, WLAN, Bluetooth
        self.nixosModules.Languages # Sprach- und Regionseinstellungen
        self.nixosModules.Pipewire # Audio
        self.nixosModules.Gnome # Desktop-Umgebung
        inputs.home-manager.nixosModules.home-manager
      ];
    };
}