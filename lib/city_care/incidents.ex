defmodule CityCare.Incidents do
  import Ecto.Query

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

  def filter_incidents(filter) do
    Incident
    |> with_status(filter["status"])
    |> search_by(filter["q"])
    |> sort(filter["sort_by"])
    |> Repo.all()
  end

  defp with_status(query, status) when status in ~w(pending resolved canceled) do
    where(query, status: ^status)
  end

  defp with_status(query, _status), do: query

  defp search_by(query, q) when q in ["", nil], do: query

  defp search_by(query, q) do
    where(query, [i], ilike(i.name, ^"%#{q}%"))
  end

  defp sort(query, "name") do
    order_by(query, :name)
  end

  defp sort(query, "priority_desc") do
    order_by(query, desc: :priority)
  end

  defp sort(query, "priority_asc") do
    order_by(query, asc: :priority)
  end

  defp sort(query, _) do
    order_by(query, :id)
  end
end
