defmodule PhilWeb.Router do
  use PhilWeb, :router

  alias Logster.Plugs.ChangeLogLevel

  @redirect_http Application.compile_env(:phil, :redirect_http?)

  pipeline :set_log_level do
    plug(ChangeLogLevel, to: :info)
  end

  pipeline :redirect_http do
    if @redirect_http do
      plug(Plug.SSL, rewrite_on: [:x_forwarded_proto])
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhilWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => "default-src 'self';"}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/_health", PhilWeb do
    pipe_through [:set_log_level]

    get "/", HealthController, :health_check
  end

  scope "/", PhilWeb do
    pipe_through [:set_log_level, :redirect_http, :browser]

    get "/", PageController, :home

    live("/charliecards/import", Live.CharlieCards.Importer)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phil, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhilWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
