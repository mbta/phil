defmodule Phil.Repo do
  use Ecto.Repo,
    otp_app: :phil,
    adapter: Ecto.Adapters.Postgres

  require Logger

  @doc """
  Set via the `:configure` option in the Repo configuration, a function invoked
  prior to each DB connection in production. `config` is the configured
  connection values and it returns a new set of config values to be used when
  connecting.
  """
  def configure_production_connection(
        config,
        auth_token_fn \\ &ExAws.RDS.generate_db_auth_token/4
      ) do
    Logger.info("Getting configuration variables for database connection...")
    hostname = System.fetch_env!("DATABASE_HOST")
    username = System.fetch_env!("DATABASE_USER")
    database = System.fetch_env!("DATABASE_NAME")
    port = System.get_env("DATABASE_PORT", "5432") |> String.to_integer()
    maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

    Logger.info("In Phil.Repo.configure_production_connection: calling auth_token_fn")
    token = auth_token_fn.(hostname, username, port, %{})
    Logger.info("In Phil.Repo.configure_production_connection: got token")

    Keyword.merge(config,
      hostname: hostname,
      username: username,
      database: database,
      port: port,
      socket_options: maybe_ipv6,
      password: token,
      ssl_opts: [
        cacertfile: "priv/aws-cert-bundle.pem",
        verify: :verify_peer,
        server_name_indication: String.to_charlist(hostname),
        verify_fun:
          {&:ssl_verify_hostname.verify_fun/3, [check_hostname: String.to_charlist(hostname)]}
      ]
    )
  end
end
