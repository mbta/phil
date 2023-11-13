defmodule Phil.Repo.Migrations.AddPartnersTable do
  use Ecto.Migration

  def change do
    create table("partners") do
      add :name, :string
      add :type, :string

      timestamps()
    end

    create unique_index("partners", [:name])
  end
end
