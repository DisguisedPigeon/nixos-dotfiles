alias ":q" = exit
alias "cat" = bat
alias "eza" = eza --icons auto --git
alias "n" = nvim

# === Env vars ===
load-env {
  PROMPT_INDICATOR: "❯ "
  PROMPT_INDICATOR_VI_INSERT: "❯ "
  PROMPT_INDICATOR_VI_NORMAL: "❮ "
  PROMPT_MULTILINE_INDICATOR: "   :"
  PATH: ($env.PATH | split row (char esep) | append /usr/bin/env)
  CARAPACE_BRIDGES: 'bash'
}


# === Colors ===
let colors = {
  muted: "#6e6a86"
  subtle: "#908caa"
  pine: "#31748f"
  gold: "#f6c177"
  iris: "#c4a7e7"
  foam: "#9ccfd8"
  love: "#eb6f92"
  rose: "#ebbcba"
  highlight_high: "#524f67"
  highlight_med: "#403d52"

}

$env.config.color_config = {
  separator: $colors.muted
  leading_trailing_space_bg: $colors.subtle
  header: $colors.pine
  date: $colors.gold
  filesize: $colors.iris
  row_index: $colors.foam
  bool: $colors.love
  int: $colors.pine
  duration: $colors.love
  range: $colors.love
  float: $colors.love
  string: $colors.subtle
  nothing: $colors.love
  binary: $colors.love
  cellpath: $colors.love
  hints: $colors.highlight_med

  shape_garbage: { fg: $colors.highlight_high bg: $colors.love }
  shape_bool: $colors.iris
  shape_int: { fg: $colors.gold attr: b }
  shape_float: { fg: $colors.gold attr: b }
  shape_range: { fg: $colors.rose attr: b }
  shape_internalcall: { fg: $colors.foam attr: b }
  shape_external: $colors.foam
  shape_externalarg: { fg: $colors.pine attr: b }
  shape_literal: $colors.iris
  shape_operator: $colors.rose
  shape_signature: { fg: $colors.pine attr: b }
  shape_string: $colors.pine
  shape_filepath: $colors.iris
  shape_globpattern: { fg: $colors.iris attr: b }
  shape_variable: $colors.gold
  shape_flag: { fg: $colors.iris attr: b }
  shape_custom: { attr: b }
}

# === Completion ===

let carapace_completer = {|spans: list<string>|
  CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

let zoxide_completer = {|spans|
    $spans
    | skip 1
    | zoxide query -l ...$in
    | lines
    | where {|x| $x != $env.PWD}
}

let external_completer = {|spans|
  let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

  let spans = if $expanded_alias != null {
    $spans
    | skip 1
    | prepend ($expanded_alias | split row ' ' | take 1)
  } else { $spans }

  match $spans.0 {
    __zoxide_z | __zoxide_zi => $zoxide_completer
    _ => $carapace_completer
  } | do $in $spans
}

# === Aux commands ===

def hupdate [username?: string, host?: string] {
  let username: string = $username | default "dpigeon"
  let host: string = $host | default "salt"

  home-manager --flake $".#($username)-($host)" switch -b backup
}

def nupdate [host?: string] {
  let host: string = $host | default "salt"

  sudo nixos-rebuild --flake .#($host) switch
}

def fupdate [] {
  nix flake update
  let GMT_DATE = date now
    | date to-timezone GMT
    | format date "%Y/%m/%d @ %H:%M:%S"

  jj commit -m $"UPDATE FLAKE, GMT: ($GMT_DATE)"
}

def update [username?: string, host?: string] {
  fupdate
  nupdate $host
  hupdate $username $host
}

# === config ===
$env.config = {
  buffer_editor: "nvim"
  edit_mode: "vi"
  show_banner: false
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 100
      completer: $external_completer
    }
  }
}

