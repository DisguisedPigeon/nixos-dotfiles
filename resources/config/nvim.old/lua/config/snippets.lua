local ls = require "luasnip"
local types = require "luasnip.util.types"

local fmta = require("luasnip.extras.fmt").fmta

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets("gleam", {
  s(
    "f",
    fmta(
      [[
fn <name>(<args>) {
  <finish>
}
]],
      { name = i(1, "fun_name"), args = i(2, "arg1, arg2"), finish = i(0, "todo") }
    )
  ),
  s(
    "pf",
    fmta(
      [[
pub fn <name>(<args>) {
  <finish>
}
]],
      { name = i(1, "fun_name"), args = i(2, "arg1, arg2"), finish = i(0, "todo") }
    )
  ),
  s("#", fmta([[#(<v>)]], { v = i(0) })),
  s(
    "us",
    fmta([[use <values> <<- <fun>(<args>)]], {
      values = i(1),
      fun = i(2, "result.try"),
      args = i(0),
    })
  ),
  s(
    "ca",
    fmta(
      [[
case <arg> {
}
]],
      {
        arg = i(0),
      }
    )
  ),
  s(
    "le",
    fmta([[html.<element>([<attributes>], [<body>]))]], {
      element = i(1, "span"),
      attributes = i(2),
      body = i(0),
    })
  ),
  s(
    "la",
    fmta([[attribute.<attribute>(<args>)]], {
      attribute = i(1, "class"),
      args = i(0),
    })
  ),
  s(
    "lustrefile",
    fmta(
      [[
import lustre
import lustre/effect.{type Effect}
import lustre/element.{type Element}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
  Nil
}

// Model -----------------------------------------------------------------------

type Model {
  <model>
}

fn init(_: Nil) ->> #(Model, Effect(Msg)) {
  <init>
}

// Update ----------------------------------------------------------------------

type Msg<msg>

fn update(model: Model, msg: Msg) ->> #(Model, Effect(Msg)) {
  <update>
}

// View ------------------------------------------------------------------------

fn view(model: Model) ->> Element(Msg) {
  <view>
}
]],
      {
        model = c(1, { t "Model", t "ligma" }),
        init = i(2, "todo"),
        msg = c(3, {
          i(nil),
          d(nil, function(_) return sn(nil, fmta(" {\n  <message>\n}", { message = i(1) })) end),
        }),
        update = i(4, "todo"),
        view = i(0, "todo"),
      }
    )
  ),
})

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",

  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = { active = { virt_text = { { "<-", "Choices" } } } },
  },
}

vim.keymap.set({ "i", "s" }, "<c-j>", function() ls.change_choice(1) end)

ls.setup()
