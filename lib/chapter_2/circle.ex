defmodule Circle do
  @moduledoc """
    Implements basic circle functions
  """
  @pi 3.14159

  @spec area(number) :: number
  def area(r), do: r * r * @pi

  @doc """
    Computes the circumference of a circle
  """
  def circumference(r), do: 2 * r * @pi
end
