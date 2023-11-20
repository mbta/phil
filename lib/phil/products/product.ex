defmodule Phil.Products.Product do
  @moduledoc """
  Different kinds of CharlieCards.

  Name - The common name of the product.
  Ticket Type ID - A number by which AFC distinguishes product types.
  """

  use Ecto.Schema

  alias Ecto.Changeset

  alias Phil.CharlieCards.CharlieCard

  schema "products" do
    has_many(:charlie_cards, CharlieCard)

    field(:name, :string)
    field(:ticket_type_id, :integer)

    timestamps()
  end

  @doc """

  """
  def changeset(attrs) do
    %__MODULE__{}
    |> Changeset.cast(attrs, [:name, :ticket_type_id])
    |> Changeset.validate_required([:name, :ticket_type_id])
    |> Changeset.unique_constraint(:ticket_type_id)
  end
end
