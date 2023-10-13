defmodule PhilWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phil

  plug Logster.Plugs.Logger

  require Logger

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_phil_key",
    signing_salt: "2Qsjpzgk",
    same_site: "Lax"
  ]

  Logger.info("Setting up LiveView socket...")
  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  Logger.info("Setting up static file serving...")
  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :phil,
    gzip: false,
    only: PhilWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    Logger.info("Setting up code reloading...")
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :phil
  end

  Logger.info("Setting up request logger...")

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId

  Logger.info("Setting up telemetry...")
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  Logger.info("Setting up parsers...")

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  Logger.info("Setting up method override...")
  plug Plug.MethodOverride
  Logger.info("Setting up head...")
  plug Plug.Head
  Logger.info("Setting up session...")
  plug Plug.Session, @session_options
  Logger.info("Setting up router...")
  plug PhilWeb.Router
end
