defmodule CityCare.Incidents do
  alias CityCare.Incidents.Incident
  alias CityCare.Repo

  def list_incidents do
    Repo.all(Incident)
  end

  def get_incident!(id) do
    case Ecto.UUID.cast(id) do
      {:ok, uuid} -> Repo.get!(Incident, uuid)
      :error -> nil
    end
  end
end
