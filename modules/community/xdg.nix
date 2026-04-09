{
  flake.aspects.xdg.nixos =
    { pkgs, ... }:
    {
      xdg = {
        portal = {
          enable = true;
          config.common.default = [ "gtk" ];
          extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        };
        mime.defaultApplications = {
          "application/pdf" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "application/rdf+xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "application/rss+xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "application/xhtml+xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "application/xhtml_xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "application/xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "image/gif" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "image/jpeg" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "image/png" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "image/webp" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "text/html" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "text/xml" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "x-scheme-handler/http" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
          "x-scheme-handler/https" = [
            "zen-beta.desktop"
            "chromium-browser.desktop"
          ];
        };
      };
    };
}
