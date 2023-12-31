defmodule Phil.Repo.Migrations.AddCharlieCardsUniqueConstraint do
  use Ecto.Migration

  def up do
    alter table(:charlie_cards) do
      add :medium, :string, null: false

      remove :product
      add :product_id, references(:products, on_delete: :delete_all)

      modify :serial_number, :string
    end

    create unique_index(:charlie_cards, [:serial_number])
  end

  def down do
    alter table(:charlie_cards) do
      remove :serial_number
      add :serial_number, :integer

      remove :product_id
      add :product, :string
    end
  end
end
