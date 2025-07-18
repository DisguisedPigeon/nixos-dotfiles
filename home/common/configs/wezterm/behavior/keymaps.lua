local wezterm = require "wezterm"
local act = wezterm.action

return {
  keys = {
    { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
    { key = "+", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },
    { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
    { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
    { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
    { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
    { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
    { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
    { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
    { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
    { key = "9", mods = "LEADER", action = act.ActivateTab(9) },
    { key = "c", mods = "LEADER", action = act.CopyTo "Clipboard" },
    { key = "f", mods = "LEADER", action = act.Search "CurrentSelectionOrEmptyString" },
    { key = "k", mods = "LEADER", action = act.ClearScrollback "ScrollbackOnly" },
    { key = "d", mods = "LEADER", action = act.ShowDebugOverlay },
    { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
    { key = "t", mods = "LEADER", action = act.SpawnTab "CurrentPaneDomain" },
    {
      key = "u",
      mods = "LEADER",
      action = act.CharSelect { copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" },
    },
    { key = "v", mods = "LEADER", action = act.PasteFrom "Clipboard" },
    { key = "w", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },
    { key = "x", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "phys:Space", mods = "LEADER", action = act.QuickSelect },
    { key = "PageUp", mods = "CTRL", action = act.ActivateTabRelative(-1) },
    { key = "PageDown", mods = "CTRL", action = act.ActivateTabRelative(1) },
  },

  key_tables = {
    copy_mode = {
      { key = "Tab", mods = "NONE", action = act.CopyMode "MoveForwardWord" },
      { key = "Tab", mods = "SHIFT", action = act.CopyMode "MoveBackwardWord" },
      { key = "Enter", mods = "NONE", action = act.CopyMode "MoveToStartOfNextLine" },
      {
        key = "Escape",
        mods = "NONE",
        action = act.Multiple { "ScrollToBottom", { CopyMode = "Close" } },
      },
      { key = "Space", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "$", mods = "NONE", action = act.CopyMode "MoveToEndOfLineContent" },
      { key = "$", mods = "SHIFT", action = act.CopyMode "MoveToEndOfLineContent" },
      { key = ",", mods = "NONE", action = act.CopyMode "JumpReverse" },
      { key = "0", mods = "NONE", action = act.CopyMode "MoveToStartOfLine" },
      { key = ";", mods = "NONE", action = act.CopyMode "JumpAgain" },
      {
        key = "F",
        mods = "NONE",
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        key = "F",
        mods = "SHIFT",
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      { key = "G", mods = "NONE", action = act.CopyMode "MoveToScrollbackBottom" },
      { key = "G", mods = "SHIFT", action = act.CopyMode "MoveToScrollbackBottom" },
      { key = "H", mods = "NONE", action = act.CopyMode "MoveToViewportTop" },
      { key = "H", mods = "SHIFT", action = act.CopyMode "MoveToViewportTop" },
      { key = "L", mods = "NONE", action = act.CopyMode "MoveToViewportBottom" },
      { key = "L", mods = "SHIFT", action = act.CopyMode "MoveToViewportBottom" },
      { key = "M", mods = "NONE", action = act.CopyMode "MoveToViewportMiddle" },
      { key = "M", mods = "SHIFT", action = act.CopyMode "MoveToViewportMiddle" },
      { key = "O", mods = "NONE", action = act.CopyMode "MoveToSelectionOtherEndHoriz" },
      { key = "O", mods = "SHIFT", action = act.CopyMode "MoveToSelectionOtherEndHoriz" },
      {
        key = "T",
        mods = "NONE",
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        key = "T",
        mods = "SHIFT",
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      { key = "V", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "V", mods = "SHIFT", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "^", mods = "NONE", action = act.CopyMode "MoveToStartOfLineContent" },
      { key = "^", mods = "SHIFT", action = act.CopyMode "MoveToStartOfLineContent" },
      { key = "b", mods = "NONE", action = act.CopyMode "MoveBackwardWord" },
      { key = "b", mods = "ALT", action = act.CopyMode "MoveBackwardWord" },
      { key = "b", mods = "CTRL", action = act.CopyMode "PageUp" },
      {
        key = "c",
        mods = "CTRL",
        action = act.Multiple { "ScrollToBottom", { CopyMode = "Close" } },
      },
      { key = "d", mods = "CTRL", action = act.CopyMode { MoveByPage = 0.5 } },
      { key = "e", mods = "NONE", action = act.CopyMode "MoveForwardWordEnd" },
      {
        key = "f",
        mods = "NONE",
        action = act.CopyMode { JumpForward = { prev_char = false } },
      },
      { key = "f", mods = "ALT", action = act.CopyMode "MoveForwardWord" },
      { key = "f", mods = "CTRL", action = act.CopyMode "PageDown" },
      { key = "g", mods = "NONE", action = act.CopyMode "MoveToScrollbackTop" },
      {
        key = "g",
        mods = "CTRL",
        action = act.Multiple { "ScrollToBottom", { CopyMode = "Close" } },
      },
      { key = "h", mods = "NONE", action = act.CopyMode "MoveLeft" },
      { key = "j", mods = "NONE", action = act.CopyMode "MoveDown" },
      { key = "k", mods = "NONE", action = act.CopyMode "MoveUp" },
      { key = "l", mods = "NONE", action = act.CopyMode "MoveRight" },
      { key = "m", mods = "ALT", action = act.CopyMode "MoveToStartOfLineContent" },
      { key = "o", mods = "NONE", action = act.CopyMode "MoveToSelectionOtherEnd" },
      {
        key = "q",
        mods = "NONE",
        action = act.Multiple { "ScrollToBottom", { CopyMode = "Close" } },
      },
      {
        key = "t",
        mods = "NONE",
        action = act.CopyMode { JumpForward = { prev_char = true } },
      },
      { key = "u", mods = "CTRL", action = act.CopyMode { MoveByPage = -0.5 } },
      { key = "v", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "v", mods = "CTRL", action = act.CopyMode { SetSelectionMode = "Block" } },
      { key = "w", mods = "NONE", action = act.CopyMode "MoveForwardWord" },
      {
        key = "y",
        mods = "NONE",
        action = act.Multiple {
          { CopyTo = "ClipboardAndPrimarySelection" },
          { Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
        },
      },
      { key = "PageUp", mods = "NONE", action = act.CopyMode "PageUp" },
      { key = "PageDown", mods = "NONE", action = act.CopyMode "PageDown" },
      { key = "End", mods = "NONE", action = act.CopyMode "MoveToEndOfLineContent" },
      { key = "Home", mods = "NONE", action = act.CopyMode "MoveToStartOfLine" },
    },

    search_mode = {
      { key = "Enter", mods = "NONE", action = act.CopyMode "PriorMatch" },
      { key = "Escape", mods = "NONE", action = act.CopyMode "Close" },
      { key = "n", mods = "CTRL", action = act.CopyMode "NextMatch" },
      { key = "p", mods = "CTRL", action = act.CopyMode "PriorMatch" },
      { key = "r", mods = "CTRL", action = act.CopyMode "CycleMatchType" },
      { key = "u", mods = "CTRL", action = act.CopyMode "ClearPattern" },
      { key = "PageUp", mods = "NONE", action = act.CopyMode "PriorMatchPage" },
      { key = "PageDown", mods = "NONE", action = act.CopyMode "NextMatchPage" },
      { key = "UpArrow", mods = "NONE", action = act.CopyMode "PriorMatch" },
      { key = "DownArrow", mods = "NONE", action = act.CopyMode "NextMatch" },
    },
  },
}
