defmodule CityCareWeb.AdminIncidentLive.Form do
alias CityCare.Incidents
alias CityCare.Incidents.Incident
  use CityCareWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:title_page, "New Incident")
      |> assign(:form, to_form(%{}, as: "incident"))

      {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <.header>
        <%= @page_title %>
      </.header>
      <.simple_form for={@form} id="incident-form" phx-submit="save">
        <.input field={@form[:name]} label="Name" />

        <.input field={@form[:description]} type="textarea" label="Description" />

        <.input field={@form[:priority]} type="number" label="Priority" />

        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a status"
          options={[:pending, :resolved, :canceled]}
        />

        <.input field={@form[:image_path]} label="Image Path" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Incident</.button>
        </:actions>
      </.simple_form>

      <.back navigate={~p"/admin/incidents"}>Back</.back>
    """
  end

  def handle_event("save", %{"incident" => incident_params}, socket) do
    Incidents.create_incident(incident_params)
    socket = push_navigate(socket, to: ~p"/admin/incidents")

    {:noreply, socket}
  end
end
