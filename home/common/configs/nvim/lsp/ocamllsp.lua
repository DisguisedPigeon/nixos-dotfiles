local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "menhir", "ocamlinterface", "ocamllex", "reason", "dune" },
  get_language_id = {
    menhir = 'ocaml.menhir',
    ocaml = 'ocaml',
    ocamlinterface = 'ocaml.interface',
    ocamllex = 'ocaml.ocamllex',
    reason = 'reason',
    dune = 'dune',
  },
  root_markers = { '*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace' }
}
