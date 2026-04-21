{ self, ... }: {

    flake.nixosModules.Noctalia = { config, pkgs, ... }: {

        # Enable the Noctalia theme.
        services.noctalia.enable = true;

    };
}