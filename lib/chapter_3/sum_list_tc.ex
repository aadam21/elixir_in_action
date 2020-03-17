defmodule SumListTc do
  @doc """
    Summing of a list using tail call optimization. The private do_sum/2
    function sums the head of a given list and the value of an accumulator
    named `current_sum`. This sum is passed in a tail recursive call with the
    tail of the given list, and recursion continues until the list is empty
  """
  def sum(list) do
    do_sum(0, list)
  end

  defp do_sum(current_sum, []) do
    current_sum
  end

  defp do_sum(current_sum, [head | tail]) do
    new_sum = head + current_sum
    do_sum(new_sum, tail)
  end
end
