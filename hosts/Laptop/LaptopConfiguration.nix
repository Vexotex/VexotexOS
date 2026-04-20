{ self, inputs, ...}: {

    flake.nixosModules.LaptopConfiguration = { config, pkgs, ... }: {

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.vexotex = self.homeModules.LaptopHome;

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Bootloader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "VexOS";

        # Set your time zone.
        time.timeZone = "Europe/Berlin";

        # Enable CUPS to print documents.
        services.printing.enable = true;

        # Enable touchpad support (enabled default in most desktopManager).
        # services.xserver.libinput.enable = true;

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

            # dev Apps
            vscode
            stm32cubemx
            # dev tools
            nodejs
            uv
            ollama

            # CLI tools
            curl # Command-line tool for transferring data with URLs.
            vim
            neovim
            fd # Fast file finder.
            ripgrep # Fast search tool, alternative to grep.
            htop # Interactive process viewer.
            gotop
            tree # Display directory structure in a tree-like format.
            openssl # Cryptographic library, that implements the SSL and TLS protocols and provides various cryptographic algorithms.
        ];

        system.stateVersion = "25.11";

    };
}