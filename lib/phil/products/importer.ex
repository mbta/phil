defmodule Phil.Products.Importer do
  @moduledoc """
  Imports Products into Phil.
  """

  alias NimbleCSV.RFC4180, as: CSV

  alias Phil.Products.Product
  alias Phil.Repo

  @doc """
  Given the path of a file, this function attempts to import Products.

  It returns a map of successes and failures like %{error: [], ok: []}.
  Error entries are changesets and success entries are the inserted struct.
  """
  # sobelow_skip ["Traversal.FileModule"]
  def import(path) do
    path
    |> File.read!()
    |> CSV.parse_string(skip_headers: false)
    |> Enum.map(&row_to_changeset/1)
    |> Enum.map(fn changeset ->
      if changeset.valid? do
        Repo.insert(changeset)
      else
        {:error, changeset}
      end
    end)
    |> Enum.group_by(fn {status, _} -> status end, fn {_, value} -> value end)
  end

  defp row_to_changeset(row) do
    Product.changeset(%{
      name: Enum.at(row, 0),
      ticket_type_id: Regex.replace(~r/\s/u, Enum.at(row, 1), "")
    })
  end
end
