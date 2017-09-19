defmodule MongoErrorTest.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_state) do
    database = Application.get_env(:mongo_error_test, :database)
    Mongo.start_link(database: database)
  end

  def find(pid, collection, query) do
    GenServer.call(pid, {:find, collection, query})
  end

  @doc """
  Reuse an existing connection and query mongo
  """
  def handle_call({:find, collection, query}, _from, conn) do
    IO.inspect(conn, label: "Calling find")

    results = Mongo.find_one(conn, collection, query)
    {:reply, results, conn}
  end

end