{ self, ... }: {

    flake.nixosModules.Docker = { ... }: {

        virtualisation.docker.enable = true;
        users.extraGroups.docker.members = [ "Vexotex" ];

    };

}