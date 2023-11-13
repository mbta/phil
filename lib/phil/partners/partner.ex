defmodule Phil.Partners.Partner do
  @moduledoc """

  """

  use Ecto.Schema

  alias Phil.Shipments.BulkShipment

  @types ~w(municipality)a

  schema "partners" do
    has_many(:bulk_shipments, BulkShipment)

    field(:name, :string)
    field(:type, Ecto.Enum, values: @types)

    timestamps()
  end
end
