defmodule Phil.CharlieCards.CharlieCardTest do
  use Phil.DataCase, async: true

  alias Phil.CharlieCards.CharlieCard
  alias Phil.Repo
  alias Phil.Support.Factories.CharlieCardFactory

  describe "changeset/1" do
    test "enforces a unique constraint on serial numbers" do
      CharlieCardFactory.insert(:charlie_card, serial_number: "1")

      charlie_card =
        CharlieCardFactory.build(:charlie_card, serial_number: "1")
        |> Map.from_struct()
        |> CharlieCard.changeset()

      assert {:error, changeset} = Repo.insert(charlie_card)
      assert {"has already been taken", _} = changeset.errors[:serial_number]
    end
  end

  test "products/0 returns a list of atoms" do
    products = CharlieCard.products()

    for a <- products, do: assert(is_atom(a))
  end

  test "statuses/0 returns a list of atoms" do
    statuses = CharlieCard.statuses()

    for a <- statuses, do: assert(is_atom(a))
  end
end
