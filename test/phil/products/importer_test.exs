defmodule Phil.Products.ImporterTest do
  use Phil.DataCase, async: true

  alias Phil.Products.Importer

  describe "import/1" do
    test "returns 4 successes and 1 failure based on one duplicate in the data" do
      result = Importer.import("test/support/fixtures/products_import.csv")

      assert Kernel.length(result.ok) == 4
      assert Kernel.length(result.error) == 1
    end
  end
end
