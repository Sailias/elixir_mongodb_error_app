defmodule MongoErrorTest do
  
  use Application

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, MongoErrorTest.Worker},
      {:size, 1},
      {:max_overflow, 20}
    ]
  end

  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: MongoErrorTest.Supervisor]
    Supervisor.start_link(children, opts)
  end


end
