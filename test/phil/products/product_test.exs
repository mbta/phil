defmodule Phil.Products.ProductTest do
  use Phil.DataCase, async: true

  alias Phil.Products.Product
  alias Phil.Repo
  alias Phil.Support.Factories.ProductFactory

  describe "changeset/1" do
    test "enforces a unique constraint on ticket_type_id" do
      existing_product = ProductFactory.insert(:product)

      new_product =
        ProductFactory.build(:product, ticket_type_id: existing_product.ticket_type_id)
        |> Map.from_struct()
        |> Product.changeset()

      assert {:error, changeset} = Repo.insert(new_product)
      assert {"has already been taken", _} = changeset.errors[:ticket_type_id]
    end
  end
end
