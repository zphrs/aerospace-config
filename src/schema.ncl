let Commands = {
  close = ["-h|--help", "--quit-if-last-window", "--window-id"]
}
in

let Command =
  std.contract.from_validator (fun value =>
    let [cmd, ..args] = std.string.split " " value
    in
    [cmd, args]
    |> match {
      ["test", args] => 'Ok,
      [unk_cmd, _] =>
        'Error { message = "unknown command: %{cmd}" },
    }
  )
in
{
  Schema = { cmd | Command = "test l" }
}
