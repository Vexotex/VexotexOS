{ self, ... }: {

    flake.nixosModules.UserVexotex = { ... }: {

        users.users.vexotex = {
            isNormalUser = true;
            description = "Vexotex";
            extraGroups = [ "networkmanager" "wheel" ];
        };

        services.fprintd.enable = true;

    };
}
