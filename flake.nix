{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = { self, nixpkgs }: {
    nixosModules = {
      # Basic module, this will allow you to create a bootable iso, and provide some basic utilities.
      default = {...}: {
        imports = [
          # Basic iso setup, gives us the ability to build an iso.
          "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
          # Support a wide range of hardware, using the config used by the usb
          # installer
          "${nixpkgs}/nixos/modules/profiles/all-hardware.nix"
          # Install tools useful for install and rescue
          "${nixpkgs}/nixos/modules/profiles/base.nix"
        ];
      };
      full = {...}: {
        imports = [
          self.nixosModules.default
          # Add common tools.
          ./modules/common.nix
        ];
      };
    };
    ## TODO every system needs to have a user to boot into.
    nixosConfigurations = let nixosSystem =  nixpkgs.lib.nixosSystem; 
    in
    {
      # Build:
      # TODO replace this with the github reference.
      # nix build .#nixosConfigurations.usbkey.config.system.build.isoImage
      usbkey = nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          self.nixosModules.default
          # TODO get something like this.
          # ./machines/usbkey
        ];
      };
      # Full system. Never leave home without it.
      full = nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          self.nixosModules.full
        ];
      };
    };
  };
}
