defmodule MultiDict do
  def new(), do: %{}

  @doc """
    Add a new Todo entry. A map representing a Todo List is expected, along
    with a date and value to be associated with that date. Map.update/4 takes
    a Map, key, initial value, and updater lambda. If no value exists for the
    key, the initial value is used. Otherwise, the updater lambda is called
    with the existing value for the matched key, and returns a new value for
    that key.

    Here, if there are no entries for a given date, a new list with the initial
    value is added with the dict as key. Otherwise, the updater lambda receives
    the existing values for the date and adds the new item to the top of list
  """
  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  @doc """
    Given a Todo List (a map) and a key, return all values for that key. If the
    key is not present, a default value of an empty list is returned
  """
  def get(dict, key) do
    Map.get(dict, key, [])
  end
end
