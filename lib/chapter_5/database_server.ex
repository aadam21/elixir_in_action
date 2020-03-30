defmodule DatabaseServer do
  @moduledoc """
    Implement a server without using the GenServer abstraction. In this case
    it mimics a database server. To test, see below:

    iex(1)> server_pid = DatabaseServer.start()
    iex(2)> DatabaseServer.run_async(server_pid, "query 1")
    iex(3)> DatabaseServer.get_result()
    "Connection 323: query 1 result"

    iex(4)> DatabaseServer.run_async(server_pid, "query 2") iex(5)> DatabaseServer.get_result()
    "Connection 323: query 2 result"
  """

  @doc """
    Interface function called by clients to open the connection
  """
  def start do
    spawn(fn ->
      connection = :rand.uniform(1000)
      loop(connection)
    end)
  end

  @doc """
    Receives the PID of the database server and a query to run, and sends the
    appropriate message to the server and does nothing else. The caller then
    goes about its business
  """
  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  @doc """
    Called by the client when the result of the async query call is needed or
    wanted. The result is returned in the receive clause, and the after clause
    handles cases where something may go wrong during the query execution and
    a response is never received.
  """
  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, :timeout}
    end
  end

  # This Implementation function runs in the server process and is called by
  # the Interface function loop/1, which keeps the state via the connection
  defp loop(connection) do
    receive do
      {:run_query, from_pid, query_def} ->
        query_result = run_query(connection, query_def)
        send(from_pid, {:query_result, query_result})
    end

    loop(connection)
  end

  defp run_query(connection, query_def) do
    Process.sleep(2000)
    "Connection #{connection}: #{query_def} result"
  end
end
