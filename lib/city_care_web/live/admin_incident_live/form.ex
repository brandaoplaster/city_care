defmodule CityCareWeb.AdminIncidentLive.Form do
  use CityCareWeb, :live_view

  alias CityCare.Incidents.Incident
  alias CityCare.Incidents

  def mount(_params, _session, socket) do
    changeset = Incidents.change_incident(%Incident{})

    socket =
      socket
      |> assign(:title_page, "New Incident")
      |> assign(:form, to_form(changeset))

      {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <.header>
        <%= @page_title %>
      </.header>
      <.simple_form for={@form} id="incident-form" phx-submit="save" phx-change="validate">
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

  def handle_event("validate", %{"incident" => params}, socket) do
    changeset = Incidents.change_incident(%Incident{}, params)
    socket =
      socket
      |> assign(:form, to_form(changeset, action: :validate))

    {:noreply, socket}
  end
end
