defmodule Exercises.RecursionPractice do
  @moduledoc """
    Practice working with recursive calls that are not tail call optimized
  """

  @doc """
    Recursively calculate the length of a given list
  """
  def list_len([]), do: 0
  def list_len([_ | tail]) do
    1 + list_len(tail)
  end

  @doc """
    Accept a starting and ending number representing a range, and recursively
    build and return a list of the full range
  """
  def range(from, to) when from > to, do: []
  def range(from, to) do
    [from | range(from + 1, to)]
  end

  @doc """
    Accept a list and return a list with any non-positive values dropped
  """
  def positive([]), do: []
  def positive([head | tail]) when head > 0 do
    [head | positive(tail)]
  end
  def positive([_ | tail]) do
    positive(tail)
  end
end
