defmodule TodoList do
  @moduledoc """
    Module for handling CRUD operations on a TODO struct. See Chapter4.TodoCrud
    for full documentation
  """
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end
  def update_entry(todo_list, entry_id, updater_function) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_function.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end

defmodule TodoList.CsvImporter do
  @moduledoc """
    Module for importing a CSV, extracting its contents, and using each line to
    create a TodoList instance. For the sake of this exercise, it's safe to
    assume each line in the file describes a single Todo entry (date, entry),
    the file is always available, in the correct format, and the comma
    character does not appear in the entry title - it's only present as a
    separator. The file is also assumed to be in the same directory. I've put
    a file `todos.csv` in the top level directory with valid contents for this
    module
  """

  @doc """
    Import the file with the given file name, then call a series of private
    functions to perform operations on each line in the file. First,
    read_lines/1 is called and returns a map of lines with the newline
    characters removed. That is piped to create_entries/1 which calls 2 other
    functions: extract_fields/1 splits the line on commas and builds a list of
    words/values, then pipes that to convert_date/1 where the date value is
    parsed and formatted, then included as the first value in a tuple with the
    title value as the second value. The date is parsed to be split on the
    forward slash character and then mapped as an integer, and finally the tuple
    is piped to create_entry/1 that builds a map to be piped to the TodoList
    struct's new/1 function.

    Sample call and return value (sloppy access to file):

    iex> {:ok, path} = File.cwd()
    {:ok, "/Users/adamphillips/Developer/Elixir/elixir_in_action"}

    iex> name = path <> "/lib/todos.csv"
    "/Users/adamphillips/Developer/Elixir/elixir_in_action/lib/chapter_4/todo_import/todos.csv"

    iex> TodoList.CsvImporter.import(name)
    %TodoList{
      auto_id: 4,
      entries: %{
        1 => %{date: ~D[2018-12-19], id: 1, title: "Dentist"},
        2 => %{date: ~D[2018-12-20], id: 2, title: "Shopping"},
        3 => %{date: ~D[2018-12-19], id: 3, title: "Movies"}
      }
    }
  """
  def import(file_name) do
    file_name
    |> read_lines
    |> create_entries
    |> TodoList.new()
  end

  defp read_lines(file_name) do
    file_name
    |> File.stream!()
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp create_entries(lines) do
    lines
    |> Stream.map(&extract_fields/1)
    |> Stream.map(&create_entry/1)
  end

  defp extract_fields(line) do
    line
    |> String.split(",")
    |> convert_date
  end

  defp convert_date([date_string, title]) do
    {parse_date(date_string), title}
  end

  defp parse_date(date_string) do
    [year, month, day] =
      date_string
      |> String.split("/")
      |> Enum.map(&String.to_integer/1)

    {:ok, date} = Date.new(year, month, day)
    date
  end

  defp create_entry({date, title}) do
    %{date: date, title: title}
  end
end
