defmodule Phil.Support.CharlieCardFactory do
  @moduledoc false

  use ExMachina.Ecto, repo: Phil.Repo

  alias Phil.CharlieCards.CharlieCard

  def charlie_card_factory do
    %CharlieCard{
      batch_number: Enum.random(1..9),
      batch_sequence_number: sequence("") |> String.to_integer(),
      card_valid_from: Timex.now(),
      card_valid_until: Timex.end_of_year(Timex.now()),
      product: CharlieCard.products() |> Enum.random(),
      product_valid_from: Timex.now(),
      product_valid_until: Timex.end_of_year(Timex.now()),
      production_date: Timex.now(),
      sequence_number: Enum.random(100..200),
      serial_number: Enum.random(1_000_000..5_000_000),
      status: CharlieCard.statuses() |> Enum.random()
    }
  end
end
