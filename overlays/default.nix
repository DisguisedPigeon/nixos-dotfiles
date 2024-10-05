{ inputs, ... }:
{
  nvim-nightly = inputs.neovim-nightly.overlays.default;

  additions = final: _prev: import ../pkgs final.pkgs;

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
  };
}
