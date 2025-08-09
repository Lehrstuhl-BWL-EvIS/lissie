defmodule Lissie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LissieWeb.Telemetry,
      Lissie.Repo,
      {DNSCluster, query: Application.get_env(:lissie, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lissie.PubSub},
      # Start a worker by calling: Lissie.Worker.start_link(arg)
      # {Lissie.Worker, arg},
      # Start to serve requests, typically the last entry
      LissieWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lissie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LissieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
