defmodule Phil.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhilWeb.Telemetry,
      # Start the Ecto repository
      Phil.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phil.PubSub},
      # Start Finch
      {Finch, name: Phil.Finch},
      # Start the Endpoint (http/https)
      PhilWeb.Endpoint
      # Start a worker by calling: Phil.Worker.start_link(arg)
      # {Phil.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phil.Supervisor]

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhilWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
