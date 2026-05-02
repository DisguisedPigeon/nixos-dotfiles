{
  inputs,
  pkgs,
  lib,
}:
let
  pluginSettingsPath = plugin-name: ../resources/config/noctalia/plugins/${plugin-name}/settings.json;

  fileToJson =
    path:
    lib.pipe path [
      builtins.readFile
      builtins.fromJSON
    ];

  pluginSettingsToJson =
    plugin-name:
    lib.pipe plugin-name [
      pluginSettingsPath
      fileToJson
    ];
in
inputs.wrappers.wrappers.noctalia-shell.wrap {
  inherit pkgs;

  settings = fileToJson ../resources/config/noctalia/settings.json;

  colors = fileToJson ../resources/config/noctalia/colors.json;

  pluginSettings = {
    # Also installed:
    #   polkit-agent
    #   unicode-picker

    kde-connect = pluginSettingsToJson "kde-connect";
    osk-toggle = pluginSettingsToJson "osk-toggle";
    port-monitor = pluginSettingsToJson "port-monitor";
    privacy-indicator = pluginSettingsToJson "privacy-indicator";
    screen-shot-and-record = pluginSettingsToJson "screen-shot-and-record";
    tailscale = pluginSettingsToJson "tailscale";
    usb-drive-manager = pluginSettingsToJson "usb-drive-manager";
  };

  preInstalledPlugins =
    let
      sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    in
    {
      kde-connect = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/kde-connect";
      };
      osk-toggle = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/osk-toggle";
      };
      polkit-agent = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/polkit-agent";
      };
      port-monitor = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/port-monitor";
      };
      privacy-indicator = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/privacy-indicator";
      };
      screen-shot-and-record = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/screen-shot-and-record";
      };
      tailscale = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/tailscale";
      };
      unicode-picker = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/unicode-picker";
      };
      usb-drive-manager = {
        inherit sourceUrl;
        src = "${inputs.noctalia-plugins.outPath}/usb-drive-manager";
      };
    };
}
