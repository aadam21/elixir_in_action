defmodule SimpleTodoList do
  @moduledoc """
    Module for handling the data abstraction involved in creating a Todo List
  """

  @doc """
    Create a new Todo List, using the MultiDict module
  """
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end
