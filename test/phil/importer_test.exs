defmodule Phil.CharlieCards.ImporterTest do
  use Phil.DataCase, async: true

  alias Phil.CharlieCards.Importer

  describe "import/1" do
    test "returns 9 successes and 1 failure based on one duplicate in the data" do
      result = Importer.import("test/support/fixtures/charlie_cards_import.csv")

      assert Kernel.length(result.ok) == 9
      assert Kernel.length(result.error) == 1
    end
  end
end
