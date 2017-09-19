defmodule MongoErrorTest.Tester do

  def run do
    1..4
    |> Enum.map(fn _num -> 
      spawn(MongoErrorTest.TestWorker, :listen, [])
    end)
    |> Enum.each(fn pid -> 
      # Adding a little delay, otherwise the error doesn't occur
      # this causes poolboy to spawn new workers at different times which it will then reuse 
      # before the mongo connection has been properly established
      Process.sleep(5)

      # Run the process function
      send pid, {:ok, "run"}
    end)
  end

end