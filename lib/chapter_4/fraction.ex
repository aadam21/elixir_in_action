defmodule Fraction do
  defstruct a: nil, b: nil

  @doc """
    Create a new Fraction struct, expecting the two values provided in the
    struct definition
  """
  @spec new(integer, integer) :: Fraction.t
  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  @doc """
    Accept a Fraction struct and return the decimal representation of the
    fraction. Pattern matching against the struct definition ensures we are
    getting a %Fraction{} so we can safely assume the arg is a fraction and
    operate on it accordingly
  """
  @spec value(Fraction.t) :: float
  def value(fraction) do
    fraction.a / fraction.b
  end

  @doc """
    Accept two fractions and add them. The assumption should be that the two
    denominators are different, and the approach here works either way. To jog
    elementary school memory, the steps are:

    1. Cross-multiply the fractions: numerator1 * denominator2 and
       denominator1 * numerator2
       * e.g. 1/3 + 2/5 == 1 * 5 (5) and 2 * 3 (6)
    2. Add the results of the cross multiplication in step 1 (5 + 6 = 11) - this
       gives you the numerator of the final answer
    3. Multiply the two denominators to get the denominator of the final
       answer. In this example, (3 * 5 = 15)
    4. As a fraction, the final answer is 1/3 + 2/5 = 11/15

    This function handles the addition and returns a Fraction struct with the
    answer. This can be piped to value/1 to obtain a decimal representation
  """
  @spec add(Fraction.t, Fraction.t) :: Fraction.t
  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(a1 * b2 + a2 * b1,
      b2 * b1
    )
  end
end
