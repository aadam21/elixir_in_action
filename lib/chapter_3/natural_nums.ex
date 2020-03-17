defmodule NaturalNums do
  @doc """
    Recursively print the first `n` natural numbers (positive integers)
    Add a guard to force a positive integer value, catching bad values and
    returning an :error tuple
  """
  def print(1), do: IO.puts(1)
  def print(n) when is_integer(n) and n >= 1 do
    print(n - 1)
    IO.puts(n)
  end
  def print(_), do: {:error, "Please only enter a positive integer value"}
end
