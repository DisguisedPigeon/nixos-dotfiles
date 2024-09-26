# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    vimPlugins = prev.vimPlugins // {
      render-markdown-nvim = prev.vimUtils.buildVimPlugin {
        pname = "render-markdown.nvim";
        version = "2024-08-29";
        src = prev.fetchFromGitHub {
          owner = "MeanderingProgrammer";
          repo = "render-markdown.nvim";
          rev = "bc8213ddcd91d2045cc3813df861adb93fbf2d2d";
          hash = "sha256-kWENpKZZhqUFYsJkJFts6J0Wc9hhRPV0G8X0TJY9GlU=";
        };
        meta.homepage = "https://github.com/MeanderingProgrammer/render-markdown.nvim/";
      };
    };
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
}
