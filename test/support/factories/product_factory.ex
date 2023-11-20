defmodule Phil.Support.Factories.ProductFactory do
  @moduledoc false

  use ExMachina.Ecto, repo: Phil.Repo

  alias Phil.Products.Product

  def product_factory do
    %Product{
      name: Faker.Pokemon.name(),
      ticket_type_id: Enum.random(1_000_000..5_000_000)
    }
  end
end
