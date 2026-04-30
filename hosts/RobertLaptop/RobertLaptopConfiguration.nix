{ self, inputs, ...}: {

    flake.nixosModules.RobertLaptopConfiguration = { config, pkgs, ... }: {

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.lordhase = self.homeModules.RobertLaptopHome;

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Bootloader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "LordsServant";

        # Set your time zone.
        time.timeZone = "Europe/Berlin";

        # Enable CUPS to print documents.
        services.printing.enable = true;

        # Enable touchpad support (enabled default in most desktopManager).
        # services.xserver.libinput.enable = true;

        programs.xwayland.enable = true;
        programs.niri.enable = true;

        # Notwendig damit vorkompilierte Fremdbinaries laufen, die nicht für NixOS gebaut wurden. Betrifft z.B. VSCode-Extensions, Sprachserver (LSPs), heruntergeladene CLI-Tools.
        programs.nix-ld.enable = true;

        # Install firefox.
        programs.firefox.enable = true;

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
            # Applications
            discord
            spotify
            obsidian
            localsend

            # compatability with win
            wineWow64Packages.stable

            # CLI tools
            curl 
            vim
        ];

        system.stateVersion = "25.11";

    };
}