let ExitMode = {
  esc = "mode main",
}
in

let FloatingApps = [
  "Alacritty",
  "Messages",
  "Mail",
  "Reminders",
  "FaceTime",
  "Weather"
]
in

let Directions = ["left", "right", "up", "down"] in

let DirectionMapping = {
  left = "h",
  right = "l",
  up = "j",
  down = "k"
}
in
let directionKeys = std.record.values DirectionMapping
in

let AppSpaces = {
  d = "Discord",
  m = "Music",
  s = "Signal",
  n = "Notes",
  p = "Passwords",
  h = "pHotos",
  o = "pOdman",
  t = "Tv"
}
in

let Zone = fun k =>
  let directionKeys = std.record.values DirectionMapping
  in
  !(std.array.any (fun x => x == k) directionKeys)
in

# contract allows for direction keys to be used in the rearrange group
# and makes sure there isn't a conflict
let Zones
  | std.contract.from_validator (fun value =>
    let checks =
      value
      |> std.record.fields
      |> std.array.map (fun k =>
        if Zone k then
          'Ok
        else
          'Error {
            message = "Key '%{k}' cannot be used as a zone shortcut key because it is also used as a direction",
            notes = [
              "The direction shortcut keys: [%{std.string.join ", " directionKeys}]",
              "Zone shortcuts and direction keys cannot conflict due to the `rearrange` mode."
            ]
          }
      )
    in
    std.array.fold_left
      (fun prev curr =>
        prev
        |> match {
          'Ok => curr,
          p => p
        }
      )
      'Ok
      checks
  )
  =
    (
      std.array.range 0 9
      |> (
        std.array.map (fun n =>
          { field = "%{n}", value = "S%{n}" }
        )
      )
      |> std.record.from_array
    )
    & {
      d = "Dev",
      p = "Personal",
      s = "School",
      x = "pleXigraph"
    }
in
{
  # Place a copy of this config to ~/.aerospace.toml
  # After that, you can edit ~/.aerospace.toml to your liking

  # You can use it to add commands that run after login to macOS user session.
  # "start-at-login" needs to be "true" for "after-login-command" to work
  # Available commands: https://nikitabobko.github.io/AeroSpace/commands
  after-login-command = [],

  # You can use it to add commands that run after AeroSpace startup.
  # "after-startup-command" is run after "after-login-command"
  # Available commands : https://nikitabobko.github.io/AeroSpace/commands
  after-startup-command = [],

  start-at-login = true,

  enable-normalization-flatten-containers = true,
  enable-normalization-opposite-orientation-for-nested-containers = true,

  accordion-padding = 48,
  default-root-container-layout = "accordion",
  default-root-container-orientation = "auto",

  on-focused-monitor-changed = ["move-mouse monitor-lazy-center"],

  automatically-unhide-macos-hidden-apps = false,

  key-mapping = {
    preset = "qwerty",
  },

  gaps = {
    inner.horizontal = 6,
    inner.vertical = 6,
    outer.left = 12,
    outer.bottom = 12,
    outer.top = 6,
    outer.right = 12,
  },

  mode = {
    main = {
      binding =
        {
          alt-shift-f = "fullscreen --no-outer-gaps",
          alt-enter = ["exec-and-forget open -na Alacritty"],
          alt-slash = "layout tiles horizontal vertical",
          alt-comma = "layout accordion horizontal vertical",
          alt-f = "layout floating tiling",
          alt-esc = "reload-config",
          alt-shift-r = "flatten-workspace-tree",
          alt-b = ["layout tiles", "balance-sizes"],
        }
        & (
          std.record.to_array DirectionMapping
          |> std.array.map (fun x =>
            {
              field = "alt-%{x.value}",
              value = "focus %{x.field}  --boundaries-action wrap-around-the-workspace --ignore-floating"
            }
          )
          |> std.record.from_array
        )
        & {
          alt-minus = "resize smart -50",
          alt-equal = "resize smart +50",
        }
        & {
          alt-a = "mode apps",
          alt-period = "mode zones",
          alt-r = "mode rearrange",
          alt-shift-j = "mode join",
        }
        & {
          alt-shift-tab = "workspace-back-and-forth",
        }
    },

    zones.binding =
      (
        Zones
        |> std.record.map (fun k v => ["workspace %{v}", "mode main"])
      )
      & (
        Zones
        |> std.record.to_array
        |> std.array.map (fun { field = f, value = v } =>
          {
            field = "alt-%{f}",
            value = ["move-node-to-workspace %{v}", "workspace %{v}", "mode main"]
          }
        )
        |> std.record.from_array
      )
      & ExitMode,

    rearrange.binding =
      (
        Zones
        |> std.record.map (fun k v => "move-node-to-workspace %{v}")
      )
      & (
        Zones
        |> std.record.to_array
        |> std.array.map (fun { field = f, value = v } =>
          {
            field = "shift-%{f}",
            value = ["move-node-to-workspace %{v}", "mode main"]
          }
        )
        |> std.record.from_array
      )
      & (
        Zones
        |> std.record.to_array
        |> std.array.map (fun { field = f, value = v } =>
          {
            field = "alt-%{f}",
            value = ["move-node-to-workspace %{v}", "workspace %{v}", "mode main"]
          }
        )
        |> std.record.from_array
      )
      & {
        h = "focus left  --boundaries-action wrap-around-the-workspace",
        j = "focus down  --boundaries-action wrap-around-the-workspace",
        k = "focus up    --boundaries-action wrap-around-the-workspace",
        l = "focus right --boundaries-action wrap-around-the-workspace",
      }
      & {
        alt-h = "move left",
        alt-j = "move down",
        alt-k = "move up",
        alt-l = "move right",
      }
      & {
        slash = "layout tiles horizontal vertical",
        comma = "layout accordion horizontal vertical",
      }
      & {
        up = "resize smart +50",
        down = "resize smart -50",
        shift-up = "resize smart-opposite -50",
        shift-down = "resize smart-opposite +50",
      }
      & ExitMode,

    apps.binding =
      (
        AppSpaces
        |> std.record.map (fun _ app =>
          ["workspace %{app}", "exec-and-forget open -a %{app}", "mode main"]
        )
      )
      & ExitMode,

    join.binding = {
      esc = ["mode main"],
      d = ["resize width 330", "resize height 340", "mode main"],
      h = ["join-with left", "mode main"],
      j = ["join-with down", "mode main"],
      k = ["join-with up", "mode main"],
      l = ["join-with right", "mode main"],
    }
  },
  on-window-detected =
    (
      AppSpaces
      |> std.record.to_array
      |> std.array.map (fun { field, value } =>
        {
          "if" = { app-name-regex-substring = "%{value}" },
          check-further-callbacks = true,
          run = ["layout floating", "move-node-to-workspace %{value}"]
        }
      )
    )
    |> std.array.concat (
      FloatingApps
      |> std.array.map (fun app =>
        {
          "if" = { app-name-regex-substring = app },
          run = ["layout floating"]
        }
      )
    )
}
