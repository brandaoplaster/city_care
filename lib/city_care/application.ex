defmodule CityCare.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CityCareWeb.Telemetry,
      CityCare.Repo,
      {DNSCluster, query: Application.get_env(:city_care, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CityCare.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CityCare.Finch},
      # Start a worker by calling: CityCare.Worker.start_link(arg)
      # {CityCare.Worker, arg},
      # Start to serve requests, typically the last entry
      CityCareWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CityCare.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CityCareWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
