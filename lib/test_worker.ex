defmodule MongoErrorTest.TestWorker do

  def listen do
    receive do
      {:ok, "run"} -> run()
    end

    listen()
  end

  defp run do
    IO.inspect("Running")

    for _ <- 1..10 do
      :poolboy.transaction(:worker, fn(pid) -> 
        MongoErrorTest.Worker.find(pid, "users", %{})
        |> IO.inspect(label: "Results")
      end)
    end

    IO.inspect("Done")
  end
end