defmodule Phil.CharlieCards.CharlieCardTest do
  use Phil.DataCase, async: true

  alias Phil.CharlieCards.CharlieCard
  alias Phil.Repo
  alias Phil.Support.Factories.CharlieCardFactory

  describe "changeset/1" do
    test "enforces a unique constraint on serial numbers" do
      existing_charlie_card = CharlieCardFactory.insert(:charlie_card)

      new_charlie_card =
        CharlieCardFactory.build(:charlie_card,
          serial_number: existing_charlie_card.serial_number
        )
        |> Map.from_struct()
        |> Map.put(:product_id, existing_charlie_card.product_id)
        |> CharlieCard.changeset()

      assert {:error, changeset} = Repo.insert(new_charlie_card)
      assert {"has already been taken", _} = changeset.errors[:serial_number]
    end
  end

  test "media/0 returns a list of atoms" do
    media = CharlieCard.media()

    for a <- media, do: assert(is_atom(a))
  end

  test "statuses/0 returns a list of atoms" do
    statuses = CharlieCard.statuses()

    for a <- statuses, do: assert(is_atom(a))
  end
end
