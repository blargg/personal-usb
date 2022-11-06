# Basic setup. This is similar to 
# https://github.com/NixOS/nixpkgs/blob/8d64b2e7f7f018556dd466154e20088d428a2708/nixos/modules/profiles/installation-device.nix
# but with a few changes.
#
# * User, and autologin
# * sudo
# * wireless config
{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/scan/detected.nix")

    # Allow "nixos-rebuild" to work by providing
    # /etc/nixos/configuration.nix
    (modulesPath + "/profiles/clone-config.nix")
    # Set up channels for installation. Not needed for flakes.
    (modulesPath + "/installer/cd-dvd/channel.nix")
  ];
  config = {
    users.users.nixos = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
      initialHashedPassword = "";
    };
    services.getty.autologinUser = "nixos";

    security.sudo.enable = true;

    networking.wireless.enable = true;
    networking.wireless.userControlled.enable = true;
  };
}
