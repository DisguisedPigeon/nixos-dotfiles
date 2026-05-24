{ inputs, pkgs, zoxide, starship, direnv, lib, runCommand}:

inputs.wrappers.wrappers.nushell.wrap {
  inherit pkgs;

  "config.nu".content =
    lib.strings.readFile ../resources/config/nu/config.nu + ''
    source ${runCommand "zoxide-nushell-config.nu" { } ''
      ${lib.getExe zoxide} init nushell --cmd cd >> "$out"
    ''}
    use ${pkgs.runCommand "starship-nushell-config.nu" { } ''
      ${lib.getExe starship} init nu >> "$out"
    ''}
    $env.config.hooks.pre_prompt = (
        $env.config.hooks.pre_prompt?
        | default []
        | append {||
        ${lib.getExe direnv} export json
            | from json --strict
            | default {}
            | items {|key, value|
                let value = do (
                    {
                      "PATH": {
                        from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
                        to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
                      }
                    }
                    | merge ($env.ENV_CONVERSIONS? | default {})
                    | get ([[value, optional, insensitive]; [$key, true, true] [from_string, true, false]] | into cell-path)
                    | if ($in | is-empty) { {|x| $x} } else { $in }
                ) $value
                return [ $key $value ]
            }
            | into record
            | load-env
        }
    )
  '';
}
