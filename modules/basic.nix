# Basic setup. This is similar to 
# https://github.com/NixOS/nixpkgs/blob/8d64b2e7f7f018556dd466154e20088d428a2708/nixos/modules/profiles/installation-device.nix
# but with a few changes.
#
# * User, and autologin
# * sudo
# * wireless config
{ ... }:
{
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
