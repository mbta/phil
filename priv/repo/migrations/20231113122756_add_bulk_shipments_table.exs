defmodule Phil.Repo.Migrations.AddBulkShipmentsTable do
  use Ecto.Migration

  def change do
    create table("bulk_shipments") do
      add :partner_id, references(:partners)

      timestamps()
    end
  end
end
