let CommandVariants = {
  balance-sizes = [
    "[-h|--help] [--workspace <workspace>]"
  ],
  close = [
    "[-h|--help] [--quit-if-last-window] [--window-id <window-id>]"
  ],
  close-all-windows-but-current = [
    "[-h|--help] [--quit-if-last-window]"
  ],
  enable = [
    "[-h|--help] toggle",
    "[-h|--help] on [--fail-if-noop]",
    "[-h|--help] off [--fail-if-noop]"
  ],
  exec-and-forget = [
    "<bash-script>"
  ],
  flatten-workspace-tree = [
    "[-h|--help] [--workspace <workspace>]"
  ],
  focus = [
    "[-h|--help] [--ignore-floating] [--boundaries <boundary>] [--boundaries-action <action>] (left|down|up|right)",
    "[-h|--help] --window-id <window-id>",
    "[-h|--help] --dfs-index <dfs-index>"
  ],
  focus-back-and-forth = [
    "[-h|--help]"
  ],
  focus-monitor = [
    "[-h|--help] [--wrap-around] (left|down|up|right)",
    "[-h|--help] [--wrap-around] (next|prev)",
    "[-h|--help] <monitor-pattern>..."
  ],
  fullscreen = [
    "[-h|--help] [--window-id <window-id>] [--no-outer-gaps]",
    "[-h|--help] on [--window-id <window-id>] [--no-outer-gaps] [--fail-if-noop]",
    "[-h|--help] off [--window-id <window-id>] [--fail-if-noop]"
  ],
  join-with = [
    "[-h|--help] [--window-id <window-id>] (left|down|up|right)"
  ],
  layout = [
    "[-h|--help] [--window-id <window-id>] (h_tiles|v_tiles|h_accordion|v_accordion|tiles|accordion|horizontal|vertical|tiling|floating)..."
  ],
  macos-native-fullscreen = [
    "[-h|--help] [--window-id <window-id>]",
    "[-h|--help] [--window-id <window-id>] [--fail-if-noop] on",
    "[-h|--help] [--window-id <window-id>] [--fail-if-noop] off"
  ],
  mode = [
    "[-h|--help] <binding-mode>"
  ],
  move = [
    "[-h|--help] [--window-id <window-id>] (left|down|up|right)"
  ],
  move-mouse = [
    "[-h|--help] [--fail-if-noop] <mouse-position>"
  ],
  move-node-to-monitor = [
    "[-h|--help] [--window-id <window-id>] [--focus-follows-window] [--fail-if-noop] [--wrap-around] (left|down|up|right|next|prev)",
    "[-h|--help] [--window-id <window-id>] [--focus-follows-window] [--fail-if-noop] <monitor-pattern>..."
  ],
  move-node-to-workspace = [
    "[-h|--help] [--focus-follows-window] [--wrap-around] (next|prev)",
    "[-h|--help] [--focus-follows-window] [--fail-if-noop] [--window-id <window-id>] <workspace-name>"
  ],
  move-workspace-to-monitor = [
    "[-h|--help] [--workspace <workspace>] [--wrap-around] (left|down|up|right)",
    "[-h|--help] [--workspace <workspace>] [--wrap-around] (next|prev)",
    "[-h|--help] [--workspace <workspace>] <monitor-pattern>..."
  ],
  reload-config = [
    "[-h|--help] [--no-gui] [--dry-run]"
  ],
  resize = [
    "[-h|--help] [--window-id <window-id>] (smart|smart-opposite|width|height) [+|-]<number>"
  ],
  split = [
    "[-h|--help] [--window-id <window-id>] (horizontal|vertical|opposite)"
  ]
}
in
std.record.map CommandVariants
