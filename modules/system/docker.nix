{ self, ... }: {

    flake.systemModules.Docker = { ... }: {

        virtualisation.docker.enable = true;virtualisation.docker.enable = true;
        users.extraGroups.docker.members = [ "Vexotex" ];

    };

}