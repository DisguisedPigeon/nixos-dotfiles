{ config, lib, ... }:
{
  options = {
    userlist = lib.mkOption { };
    # attrset of users with admin bool
    #
    # userlist = [
    #   a = true;
    #   b = false;
    #   c = false;
    # ];

    adminConfigs = lib.mkOption { };
    # this is supposed to be plugged into users.users
    #
    # adminConfigs = {
    #   shell = pkgs.zsh;
    #   isNormalUser = true;
    #   ...
    # };

    userConfigs = lib.mkOption { };
    # this is supposed to be plugged into users.users
    #
    # userConfigs = {
    #   shell = pkgs.zsh;
    #   isNormalUser = true;
    #   ...
    # };
  };

  config =
    let
      admin = lib.attrsets.recursiveUpdate { extraGroups = [ "wheel" ]; } config.adminConfigs;
      user = { } // config.userConfigs;
      buildUser = isAdmin: if isAdmin then admin else user;
    in
    {
      users.users = builtins.mapAttrs (_: v: buildUser v) config.userlist;
    };
}
