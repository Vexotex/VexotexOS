# VexotexOS

Deklarative NixOS-Konfiguration auf Basis von Flakes, flake-parts und Home Manager.

## Struktur

```
VexotexOS/
├── flake.nix
├── flake.lock
├── hosts/
│   └── Laptop/
│       ├── Laptop.nix               # Assembler: steckt alle Module zusammen
│       ├── LaptopConfiguration.nix  # Laptop-spezifische Systemkonfiguration
│       ├── LaptopHardware.nix       # Generierte Hardware-Konfiguration (nicht anfassen)
│       └── LaptopHome.nix           # HM-Assembler für den Laptop-User
└── modules/
    ├── homeModules.nix              # Deklariert flake.homeModules als Option
    ├── home/
    │   ├── git.nix                  # programs.git → generiert ~/.gitconfig
    │   ├── gh.nix                   # programs.gh → generiert ~/.config/gh/config.yml
    │   └── ghostty.nix              # Terminal, dconf-Shortcuts, Systemstandard
    ├── system/
    │   ├── networking.nix           # NetworkManager + WiFi-Profile
    │   ├── pipewire.nix             # Audio
    │   └── languages.nix            # Programmiersprachen / Runtimes
    └── users/
        └── vexotex.nix              # Unix-User mit sudo und networkmanager
```

## Konzept

### Zwei Welten

Die Konfiguration ist in zwei Bereiche aufgeteilt:

**NixOS** verwaltet das System (benötigt root): Bootloader, Netzwerk, Dienste, Systempackages.

**Home Manager** verwaltet den User: Dotfiles, Programmkonfigurationen. `nixos-rebuild switch` generiert diese Dateien automatisch in `~/`.

Die Verbindung zwischen beiden erfolgt in `LaptopConfiguration.nix`:
```nix
home-manager.users.vexotex = self.homeModules.LaptopHome;
```

### Modulstruktur

Alle Dateien in `hosts/` und `modules/` werden von `import-tree` automatisch eingelesen — keine manuellen Imports nötig. Jede Datei folgt demselben flake-parts-Muster:

```nix
# NixOS-Modul
{ self, ... }: {
    flake.nixosModules.Name = { ... }: { /* NixOS-Optionen */ };
}

# HM-Modul
{ self, ... }: {
    flake.homeModules.Name = { ... }: { /* HM-Optionen */ };
}
```

### Rollen der Host-Dateien

| Datei | Zweck |
|-------|-------|
| `Laptop.nix` | Assembler — definiert `nixosConfigurations.Laptop`, bindet alle Module ein |
| `LaptopConfiguration.nix` | Laptop-spezifische Config — was nie auf einem anderen Rechner gelten würde |
| `LaptopHardware.nix` | Von `nixos-generate-config` generiert, wird nicht manuell bearbeitet |
| `LaptopHome.nix` | HM-Assembler — importiert alle Home-Module für diesen Host |

### Was gehört wohin?

- **`modules/`** — wiederverwendbar, könnte auf mehreren Hosts gelten
- **`hosts/Laptop/`** — spezifisch für diesen Rechner, wird nie geteilt

## System neu aufsetzen

```bash
git clone git@github.com:Vexotex/VexotexOS.git
cd VexotexOS
sudo nixos-rebuild switch --flake .#Laptop
```

Beim ersten Start nach eduroam-WLAN fragen — NetworkManager speichert das Passwort selbst.

## Offene Punkte

- **sops-nix** — für Secrets die tatsächlich in der Nix-Config referenziert werden müssen
