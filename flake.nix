{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = { self, nixpkgs }: {
    nixosModules = {
      # Basic module, this will allow you to create a bootable iso, and provide some basic utilities.
      base = {...}: {
        imports = [
          # Basic iso setup, gives us the ability to build an iso.
          # This does not have all the setup from
          # "${nixpkgs}/nixos/modules/profiles/installation-device.nix",
          # which has both passwordless root login and ssh, which is fine if
          # your computer is blank and getting set up, but problematic
          # otherwise.
          "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
          # Support a wide range of hardware, using the config used by the usb
          # installer
          "${nixpkgs}/nixos/modules/profiles/all-hardware.nix"
          # Install tools useful for install and rescue
          "${nixpkgs}/nixos/modules/profiles/base.nix"
          # Basic things needed to operate the system.
          ./modules/basic.nix
        ];
      };
      default = {...}: {
        imports = [
          # Add everything from the base version.
          self.nixosModules.base
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
      base = nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          self.nixosModules.base
        ];
      };
      # Full system. Never leave home without it.
      default = nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          self.nixosModules.default
        ];
      };
    };
  };
}
