defmodule MongoErrorTest.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def find(pid, collection, query) do
    GenServer.call(pid, {:find, collection, query})
  end

  @doc """
  Called the first time before a connection is established
  Set up a new connection and query mongo
  """
  def handle_call({:find, collection, query}, _from, nil) do
    database = Application.get_env(:mongo_error_test, :database)
    {:ok, conn} = Mongo.start_link(database: database)

    # Uncomment below to wait for mongo conn to become available
    # Process.sleep(100)
    
    IO.inspect(conn, label: "Starting worker")

    results = Mongo.find_one(conn, collection, query)

    {:reply, results, conn}
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