defmodule Phil.CharlieCards.CharlieCard do
  @moduledoc """
  A physical piece of fare media.

  Batch number - Indicates in which shipment from the manufacturer this card arrived.
  Batch sequence number - The sequential number of this card within its batch.
  Card valid from - Date the card will physically start working.
  Card valid until - Date the card will physically stop working.
  Product - The type of card: Youth Pass, Senior Pass, etc.
  Product valid from - Date the card can start being used.
  Product valid until - Date after which the card can no longer be used.
  Production date - Date the card was manufactured.
  Sequence number - The overall sequence number of the card across all batches.
  Serial number - A unique identifier for the card.
  Status - Status of the card: available or unknown, currently.
  """

  use Ecto.Schema

  alias Ecto.Changeset

  @products ~w(youth_pass)a
  @statuses ~w(afc available csp shipped testing unknown)a

  schema "charlie_cards" do
    field(:batch_number, :integer)
    field(:batch_sequence_number, :integer)
    field(:card_valid_from, :utc_datetime)
    field(:card_valid_until, :utc_datetime)
    field(:product, Ecto.Enum, values: @products)
    field(:product_valid_from, :utc_datetime)
    field(:product_valid_until, :utc_datetime)
    field(:production_date, :utc_datetime)
    field(:sequence_number, :integer)
    field(:serial_number, :string)
    field(:status, Ecto.Enum, values: @statuses)

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> Changeset.cast(attrs, __schema__(:fields) -- [:id, :inserted_at, :updated_at])
    |> Changeset.validate_required(__schema__(:fields) -- [:id, :inserted_at, :updated_at])
    |> Changeset.unique_constraint(:serial_number)
  end

  @doc """
  Return all possible product types of a CharlieCard.
  """
  def products, do: @products

  @doc """
  Return all possible statuses for a CharlieCard.
  """
  def statuses, do: @statuses
end
