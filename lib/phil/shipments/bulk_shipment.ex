defmodule Phil.Shipments.BulkShipment do
  @moduledoc """

  """

  use Ecto.Schema

  alias Phil.Media.Medium
  alias Phil.Partners.Partner

  @statuses ~w(received shipped)a

  schema "bulk_shipments" do
    belongs_to(:partner, Partner)

    has_many(:medium, Medium)

    field(:status, Ecto.Enum, values: @statuses)

    timestamps()
  end
end
