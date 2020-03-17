defmodule TodoList do
  @moduledoc """
    Module representing a CRUD version of a Todo List. The struct defines a
    default value for the `auto_id` and `entries` fields
  """

  defstruct auto_id: 1, entries: %{}

  @doc """
    Create a new instance of the TodoList struct
  """
  def new(), do: %TodoList{}

  @doc """
    Update the entry's `id` value with the value stored in the `auto_id` field
    using Map.put/3, which puts the given value (todo_list.auto_id) under the
    map's key (:id) - this covers the case of the supplied map not having an
    `id` field.

    Once updated, add the entry to the entries collection, bound to the
    `new_entries` variable.

    Lastly, add the new entry to the TodoList struct with the values from
    `new_entries`, and increment the `auto_id` field.

    Example call and return:

    iex> todo_list = TodoList.new()
              |> TodoList.add_entry(%{date: ~D[2020-03-19], title: "Dentist"})
              |> TodoList.add_entry(%{date: ~D[2020-03-20], title: "Shopping"})
              |> TodoList.add_entry(%{date: ~D[2020-03-19], title: "Movies"})
    %TodoList{
      auto_id: 4,
      entries: %{
        1 => %{date: ~D[2020-03-19], id: 1, title: "Dentist"},
        2 => %{date: ~D[2020-03-20], id: 2, title: "Shopping"},
        3 => %{date: ~D[2020-03-19], id: 3, title: "Movies"}
      }
    }
  """
  @spec add_entry(TodoList.t, Map.t) :: TodoList.t
  def add_entry(todo_list, entry) do
    entry = Map.put(
      entry,
      :id,
      todo_list.auto_id
    )

    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    %TodoList{
      todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  @doc """
    Accept a TodoList struct and a date. Starting with all entries for the
    given date, use Stream.filter/2 to filter entries in that TodoList for only
    those on the given date resulting in a collection of {id, entry} tuples for
    entries on the date. Then use Enum.map/2 to take the entry from the items
    in that collection

    Sample call and return using the bound variable shown in add_entry/2:

    iex> TodoList.entries(todo_list, ~D[2020-03-19])
    [
      %{date: ~D[2020-03-19], id: 1, title: "Dentist"},
      %{date: ~D[2020-03-19], id: 3, title: "Movies"}
    ]
  """
  @spec entries(TodoList.t, Date.t) :: Map.t
  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  @doc """
    Function for updating a Todo List entry with a given ID, using a given
    updating function. Call entries/2 to get a list of entries, then pull out
    the entry with the given id with Map.fetch/2.

    If no entry matches the ID, return the Todo List. Otherwise, confirm the ID
    of the entry hasn't been changed and then perform the updating function on
    the desired entry and bind the result to a `new_entry` variable. Store the
    modified entry in the entries collection, and finally store that updated
    collection in the TodoList instance and return the value
  """
  def update_entry(todo_list, entry_id, updater_function) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_function.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  @doc """
    Two arity update function that uses pattern matching to ensure a map is
    sent to be updated rather than some other type, then calls update_entry/3
  """
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  @doc """
    Delete the entry from a Todo List with the given ID and return the updated
    TodoList struct
  """
  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end