defmodule SumList do
  @doc """
    Recursively sum the values in a list. Recursively take the head of the list,
    then add it to the tail that's recursively passed and has the head popped
    off again
  """
  def sum([]), do: 0
  def sum([head | tail]) do
    head + sum(tail)
  end
end
