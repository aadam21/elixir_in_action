defmodule Exercises.RecursionPracticeTc do
  @moduledoc """
    Rework the same exercises from RecursionPractice.ex, but employ tail call
    optimization
  """

  @doc """
    Calculate the length of a given list
  """
  def list_len(list) do
    do_length(list, 0)
  end

  defp do_length([], current_length), do: current_length
  defp do_length([_head | tail], current_length) do
    do_length(tail, current_length + 1)
  end

  @doc """
    Build a list of a range of numbers, given a start and end number. Start
    with the end point (to), then recursively decrement that value and
    recursively add each result to the front of the list until we've
    decremented beyond the starting value (from)
  """
  def range(from, to) do
    build_range(from, to, [])
  end

  defp build_range(from, to, list) when from > to, do: list
  defp build_range(from, to, list) do
    build_range(from, to - 1, [to | list])
  end

  @doc """
    Accept a list of integers, then recursively build and return a new list
    that only contains the positive integers from the original
  """
  def positive(list), do: filter_negatives(list, [])

  # When this function is called the result will be complete but backwards
  # because we have to go through the list start to finish, building the new
  # list as we go. So we reverse the final result to put things back in order
  defp filter_negatives([], result) do
    Enum.reverse(result)
  end
  defp filter_negatives([head | tail], result) when head > 0 do
    filter_negatives(tail, [head | result])
  end
  defp filter_negatives([_ | tail], result) do
    filter_negatives(tail, result)
  end
end
