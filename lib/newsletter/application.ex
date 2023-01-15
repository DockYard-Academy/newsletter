defmodule Newsletter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Newsletter.Repo,
      # Start the Telemetry supervisor
      NewsletterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Newsletter.PubSub},
      # Start the Endpoint (http/https)
      NewsletterWeb.Endpoint
      # Start a worker by calling: Newsletter.Worker.start_link(arg)
      # {Newsletter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Newsletter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NewsletterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
