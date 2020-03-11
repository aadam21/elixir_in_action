defmodule MyModule do
  @moduledoc """
    Module to demonstrate simply hw the BEAM compiles a file. When run with the
    `elixir` command, the BEAM starts to compile the file source to memory,
    leaves code outside the module to be interpreted, then stops.

    Running with `elixir --no-halt [file_name.exs]` runs through the same two
    steps above, but the BEAM does not terminate
  """
  def run do
    IO.puts("Called MyModule.run")
  end
end
