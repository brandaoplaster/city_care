defmodule CityCareWeb.IncidentLive.Index do
  use CityCareWeb, :live_view

  import CityCareWeb.CustomComponent

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        page_title: "Incidents"
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div class="incident-index">
        <.headline>
          <.icon name="hero-trophy-mini" /> 25 Incidents Resolved This Month!
          <:tagline :let={vibe}>
            Thanks for pitching in. <%= vibe %>
          </:tagline>
        </.headline>
        <div class="incidents">
          <.incident_card :for={incident <- @incidents} incident={incident} />
        </div>
      </div>
    """
  end

  attr :incident, CityCare.Incidents.Incident, required: true

  def incident_card(assigns) do
    ~H"""
      <.link navigate={~p"/incidents/#{@incident}"}>
        <div class="card">
          <img src={@incident.image_path} />
          <h2>
            <%= @incident.name %>
          </h2>
          <div class="details">
            <.badge status={@incident.status} />
            <div class="priority">
              <%= @incident.priority %>
            </div>
          </div>
        </div>
      </.link>
    """
  end
end
