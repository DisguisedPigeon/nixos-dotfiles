{ inputs, ... }:
{
  nvim-nightly = inputs.neovim-nightly.overlays.default;

  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    maple-mono-NF = prev.stdenv.mkDerivation rec {
      pname = "MapleMono-NF";
      version = "7.0-beta35";
      src = prev.fetchurl {
        url = "https://github.com/subframe7536/Maple-font/releases/download/v${version}/${pname}.zip";
        sha256 = "sha256-fy+hdUYZDW5nkMVirhkmys3tIkWezPDrlpNxnRMl4WU=";
      };

      # Work around the "unpacker appears to have produced no directories"
      # case that happens when the archive doesn't have a subdirectory.
      sourceRoot = ".";
      nativeBuildInputs = [ prev.unzip ];
      installPhase = ''
        find . -name '*.ttf'    -exec install -Dt $out/share/fonts/truetype {} \;
        find . -name '*.otf'    -exec install -Dt $out/share/fonts/opentype {} \;
        find . -name '*.woff2'  -exec install -Dt $out/share/fonts/woff2 {} \;
      '';
      meta = with prev.lib; {
        homepage = "https://github.com/subframe7536/Maple-font";
        description = ''
          Open source Nerd Font font with round corner and ligatures for IDE and command line
        '';
        license = licenses.ofl;
        platforms = platforms.all;
        maintainers = with maintainers; [ oluceps ];
      };
    };

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
