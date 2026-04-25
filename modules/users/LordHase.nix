{ self, ... }: {

    flake.nixosModules.UserLordHase = { ... }: {

        users.users.lordhase = {
            isNormalUser = true;
            description = "LordHase";
            extraGroups = [ "networkmanager" "wheel" ];
        };

    };
}
