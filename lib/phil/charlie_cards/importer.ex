defmodule Phil.CharlieCards.Importer do
  @moduledoc """
  Imports CharlieCard inventory into Phil.
  """

  import Ecto.Query, only: [from: 2]

  alias NimbleCSV.RFC4180, as: CSV

  alias Phil.CharlieCards.CharlieCard
  alias Phil.Products.Product
  alias Phil.Repo

  @media %{"2" => :ticket, "5" => :card}

  @doc """
  Given the path of a file, this function attempts to import CharlieCards.

  It returns a map of successes and failures like %{error: [], ok: []}.
  Error entries are changesets and success entries are the inserted struct.
  """
  def import(path) do
    path
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&row_to_changeset/1)
    |> Stream.chunk_every(100)
    |> Task.async_stream(&insert_batch/1, max_concurrency: 10, ordered: false)
    |> Enum.reduce([], fn {:ok, results}, acc -> acc ++ results end)
    |> Enum.group_by(fn {status, _} -> status end, fn {_, value} -> value end)
    |> (&Map.merge(%{error: [], ok: []}, &1)).()
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

  defp row_to_changeset(row) do
    CharlieCard.changeset(%{
      batch_number: Enum.at(row, 0),
      batch_sequence_number: Enum.at(row, 1),
      card_valid_from: Enum.at(row, 8),
      card_valid_until: Enum.at(row, 9),
      medium: Map.get(@media, Enum.at(row, 4)),
      product_id:
        from(p in Product, where: p.ticket_type_id == ^Enum.at(row, 5), select: p.id)
        |> Repo.one(),
      product_valid_from: Enum.at(row, 10),
      product_valid_until: Enum.at(row, 11),
      production_date: Enum.at(row, 7),
      sequence_number: Enum.at(row, 2),
      serial_number: Enum.at(row, 3),
      status: Enum.at(row, 13) |> String.downcase()
    })
  end
end
