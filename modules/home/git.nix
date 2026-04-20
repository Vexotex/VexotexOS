{ self, ... }: {

    flake.homeModules.Git = { ... }: {

        programs.git = {
            enable = true;

            settings = {
                user.name = "Vexotex";
                user.email = "156705937+Vexotex@users.noreply.github.com";
                init.defaultBranch = "main";
                pull.rebase = true;
                push.autoSetupRemote = true;
            };
        };

        # deutlich besseres Diff-Anzeige als der Standard
        programs.delta = {
            enable = true;
            enableGitIntegration = true;
            options.side-by-side = true;
        };

    };

}
