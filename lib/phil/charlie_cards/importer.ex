defmodule Phil.CharlieCards.Importer do
  @moduledoc """

  """

  alias NimbleCSV.RFC4180, as: CSV

  alias Phil.CharlieCards.CharlieCard
  alias Phil.Repo

  def import(path) do
    path
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&row_to_changeset/1)
    |> Stream.chunk_every(100)
    |> Task.async_stream(&insert_batch/1, max_concurrency: 64, ordered: false)
  end

  defp insert_batch(changesets) do
    Enum.map(changesets, fn changeset ->
      if changeset.valid? do
        Repo.insert(changeset)
      else
        {:error, changeset}
      end
    end)
  end

  defp parse_date(string) do
    with {:ok, datetime} <- Timex.parse(string, "%-m/%d/%Y %H:%M", :strftime) do
      Timex.format!(datetime, "%Y-%m-%d %H:%M", :strftime)
    else
      _ -> "..."
    end
  end

  defp row_to_changeset(row) do
    CharlieCard.changeset(%{
      batch_number: Enum.at(row, 0),
      batch_sequence_number: Enum.at(row, 1),
      card_valid_from: Enum.at(row, 8) |> parse_date(),
      card_valid_until: Enum.at(row, 9) |> parse_date(),
      product: :youth_pass,
      product_valid_from: Enum.at(row, 10) |> parse_date(),
      product_valid_until: Enum.at(row, 11) |> parse_date(),
      production_date: Enum.at(row, 7) |> parse_date(),
      sequence_number: Enum.at(row, 2),
      serial_number: Enum.at(row, 3),
      status: Enum.at(row, 13) |> String.downcase()
    })
  end
end
