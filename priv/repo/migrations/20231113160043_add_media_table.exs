defmodule Phil.Repo.Migrations.AddMediaTable do
  @moduledoc """

  """

  use Ecto.Migration

  def change do
    create table("media") do
      add :bulk_shipment_id, references(:bulk_shipments)

      add :batch_number, :integer, null: false
      add :batch_sequence_number, :integer, null: false
      add :card_valid_from, :utc_datetime, null: false
      add :card_valid_until, :utc_datetime, null: false
      add :product, :string, null: false
      add :product_valid_from, :utc_datetime, null: false
      add :product_valid_until, :utc_datetime, null: false
      add :product_value, :decimal, null: false, default: 0.0
      add :production_date, :utc_datetime, null: false
      add :sequence_number, :integer, null: false
      add :serial_number, :integer, null: false
      add :status, :string, null: false, default: "unknown"
      add :type, :string, null: false

      timestamps()
    end
  end
end
