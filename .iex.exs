# Put aliases and functions here to have them available in your repl when you start the app.
alias Phil.Repo

IEx.configure(
  colors: [enabled: true],
  history_size: -1,
  default_prompt:
    [
      "\e[G\e[1;36m Phil \e[0m\e[1;37m📭>\e[0m"
    ]
    |> IO.chardata_to_string(),
  inspect: [
    limit: :infinity,
    pretty: true,
    syntax_colors: [
      number: :magenta,
      atom: :cyan,
      string: :green,
      boolean: :magenta,
      nil: :magenta
    ]
  ]
)
