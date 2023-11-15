defmodule PhilWeb.Live.CharlieCards.Import do
  use PhilWeb, :live_view

  alias Phil.CharlieCards.Importer

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.upload_form uploads={@uploads} />
      <.results results={@results} />
    </div>
    """
  end

  @impl true
  def handle_event("process", _params, socket) do
    results =
      consume_uploaded_entries(socket, :inventory, fn %{path: path}, _ ->
        {:ok, Importer.import(path)}
      end)
      |> List.first()

    {:noreply, assign(socket, results: Map.merge(socket.assigns.results, results))}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, assign(socket, results: %{error: [], ok: []})}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(results: %{error: [], ok: []})
     |> allow_upload(:inventory, accept: ~w(.csv), max_entries: 1)}
  end

  defp failures(assigns) do
    ~H"""
    <div
      class="bg-red-100 border border-red-200 text-sm text-red-800 rounded-lg p-4 mb-4"
      role="alert"
    >
      <h3 class="border-b-2 border-red-200 font-bold mb-4 text-xl">
        Uh oh!
        <span class="ml-1 text-sm">
          Please check these <%= Kernel.length(@failures) %> failures.
        </span>
      </h3>
      <div :for={failure <- @failures} class="mb-3">
        <p><span class="font-bold">Serial Number</span>: <%= failure.changes.serial_number %></p>
        <ul class="list-disc list-inside text-red-700">
          <li :for={error <- failure.errors}>
            <span class="underline"><%= Kernel.elem(error, 0) %></span>
            <%= Kernel.elem(error, 1) |> Kernel.elem(0) %>
          </li>
        </ul>
      </div>
    </div>
    """
  end

  defp results(assigns) do
    ~H"""
    <.successes :if={Kernel.length(@results.ok) > 0} succeses={@results.ok} />
    <.failures :if={Kernel.length(@results.error) > 0} failures={@results.error} />
    """
  end

  defp successes(assigns) do
    ~H"""
    <div
      class="bg-teal-100 border border-teal-200 text-sm text-teal-800 rounded-lg p-4 mb-4"
      role="alert"
    >
      <h3 class="border-b-2 border-teal-200 font-bold mb-4 text-xl">Nice job!</h3>
      You inserted <%= Kernel.length(@succeses) %> CharlieCards.
    </div>
    """
  end

  defp upload_form(assigns) do
    ~H"""
    <form class="flex justify-items mb-5" phx-submit="process" phx-change="validate">
      <label for="file-input" class="sr-only">Choose file</label>
      <.live_file_input
        class="block w-full border border-gray-200 mr-2 shadow-sm rounded-lg text-sm focus:z-10 focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none file:bg-gray-50 file:border-0 file:bg-gray-100 file:me-4 file:py-3 file:px-4"
        upload={@uploads.inventory}
      />
      <button
        phx-disable-with="Processing..."
        class="mx-auto py-3 px-4 inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent bg-blue-600 text-white hover:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none"
      >
        Import
      </button>
    </form>
    """
  end
end
