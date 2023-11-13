defmodule Phil.Media.Medium do
  @moduledoc """

  """

  use Ecto.Schema

  alias Phil.Shipments.BulkShipment

  @products ~w()a
  @statuses ~w(assigned available received_by_partner shipped_to_partner unknown)a
  @types ~w(card ticket)a

  schema "media" do
    belongs_to(:bulk_shipment, BulkShipment)

    field(:batch_number, :integer)
    field(:batch_sequence_number, :integer)
    field(:card_valid_from, :utc_datetime)
    field(:card_valid_until, :utc_datetime)
    field(:product, Ecto.Enum, values: @products)
    field(:product_valid_from, :utc_datetime)
    field(:product_valid_until, :utc_datetime)
    field(:product_value, :decimal)
    field(:production_date, :utc_datetime)
    field(:sequence_number, :integer)
    field(:serial_number, :integer)
    field(:status, Ecto.Enum, values: @statuses)
    field(:type, Ecto.Enum, values: @types)

    timestamps()
  end
end
