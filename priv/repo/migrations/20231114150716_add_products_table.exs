defmodule Phil.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :ticket_type_id, :integer, null: false

      timestamps()
    end

    create unique_index(:products, [:ticket_type_id])
  end
end
