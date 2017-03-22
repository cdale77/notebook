defmodule Notebook do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Notebook.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Notebook.Endpoint, []),
      # Start your own worker by calling: Notebook.Worker.start_link(arg1, arg2, arg3)
      # worker(Notebook.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Notebook.Supervisor]
    sup_ret = Supervisor.start_link(children, opts)

    #run_migrations()

    sup_ret
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Notebook.Endpoint.config_change(changed, removed)
    :ok
  end

  def run_migrations do
    Ecto.Migrator.run(Notebook.Repo, "priv/repo/migrations", :up, all: true)
  end
end
