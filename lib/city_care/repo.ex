defmodule CityCare.Repo do
  use Ecto.Repo,
    otp_app: :city_care,
    adapter: Ecto.Adapters.Postgres
end
