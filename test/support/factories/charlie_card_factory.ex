defmodule Phil.Support.Factories.CharlieCardFactory do
  @moduledoc false

  use ExMachina.Ecto, repo: Phil.Repo

  alias Phil.CharlieCards.CharlieCard
  alias Phil.Support.Factories.ProductFactory

  def charlie_card_factory do
    %CharlieCard{
      batch_number: Enum.random(1..9),
      batch_sequence_number: sequence("") |> String.to_integer(),
      card_valid_from: Timex.now() |> DateTime.truncate(:second),
      card_valid_until: Timex.now() |> Timex.end_of_year() |> DateTime.truncate(:second),
      medium: CharlieCard.media() |> Enum.random(),
      product: ProductFactory.build(:product),
      product_valid_from: Timex.now() |> DateTime.truncate(:second),
      product_valid_until: Timex.now() |> Timex.end_of_year() |> DateTime.truncate(:second),
      production_date: Timex.now() |> DateTime.truncate(:second),
      sequence_number: Enum.random(100..200),
      serial_number: Enum.random(1_000_000..5_000_000) |> Integer.to_string(),
      status: CharlieCard.statuses() |> Enum.random()
    }
  end
end
