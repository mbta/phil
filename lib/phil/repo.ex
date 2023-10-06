defmodule Phil.Repo do
  use Ecto.Repo,
    otp_app: :phil,
    adapter: Ecto.Adapters.Postgres
end
