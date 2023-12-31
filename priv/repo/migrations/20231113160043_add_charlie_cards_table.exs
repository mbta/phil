defmodule Phil.Repo.Migrations.AddCharlieCardsTable do
  use Ecto.Migration

  def change do
    create table(:charlie_cards) do
      add :batch_number, :integer, null: false
      add :batch_sequence_number, :integer, null: false
      add :card_valid_from, :utc_datetime, null: false
      add :card_valid_until, :utc_datetime, null: false
      add :product, :string, null: false
      add :product_valid_from, :utc_datetime, null: false
      add :product_valid_until, :utc_datetime, null: false
      add :production_date, :utc_datetime, null: false
      add :sequence_number, :integer, null: false
      add :serial_number, :integer, null: false
      add :status, :string, null: false, default: "unknown"

      timestamps()
    end
  end
end
