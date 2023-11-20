defmodule PhilWeb.Live.CharlieCards.ImporterTest do
  use PhilWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Phil.Products

  setup do
    Products.Importer.import("test/support/fixtures/products_import.csv")

    :ok
  end

  test "shows 9 successes and 1 failure after upload", %{conn: conn} do
    {:ok, view, _} = live(conn, ~p"/charliecards/import")

    upload(view)

    submit(view)

    html = render(view)

    assert html =~ "You inserted 9 CharlieCards."
    assert html =~ "Please check these 1 failures."
  end

  defp submit(view) do
    view
    |> form("[data-test=charlie-cards-import-form]")
    |> render_submit()
  end

  defp upload(view) do
    file_input(view, "[data-test=charlie-cards-import-form]", :inventory, [
      %{
        name: "charlie_cards_import.csv",
        content: File.read!("test/support/fixtures/charlie_cards_import.csv"),
        type: "text/csv"
      }
    ])
    |> render_upload("charlie_cards_import.csv")
  end
end
