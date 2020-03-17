defmodule Exercises.EnumStreamsPractice do
  @moduledoc """
    Module for working the second set of exercises for chapter 3, which focus
    on Enums and Streams
  """

  #  Based on code answers, this function is applied to the stream, then called
  #  by each of the exercise problems.
  #
  #  This function takes a path to a file and returns a stream of its lines.
  #  This is piped to Stream.map/2, which lazily removes the trailing newline
  #  character (\n) from each line.
  @spec filtered_lines!(String.t) :: Stream.t
  defp filtered_lines!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  @doc """
    Take a file path and pass to filtered_lines/1 to get a stream of all file
    lines with the newline characters removed. Pass that to Enum.map/1 to
    eagerly build a list of line lengths by calling String.length/1 on each
    line

    Ran iEx test to a file in my iCloud drive of 276,643 words, each on a
    unique line. Call and truncated results which were almost instant:

    iex> Exercises.EnumStreamsPractice.lines_lengths!("/Users/adamphillips/Documents/Collins\ Scrabble\ Words\ (2015).txt")
    [57, 0, 2, 3, 5, 6, 4, 3, 5, 6, 4, 8, 9, 8, 10, 5, 6, 7, 5, 6, 3, 8, 9, 2, 3, 4,
    5, 6, 5, 5, 5, 10, 9, 11, 7, 8, 6, 8, 5, 5, 6, 7, 8, 5, 8, 9, 6, 5, 7, 8, ...]
  """
  @spec lines_lengths!(String.t) :: [integer]
  def lines_lengths!(path) do
    path
    |> filtered_lines!()
    |> Enum.map(&String.length/1)
  end

  @doc """
    Take a file path and pass to filtered_lines/1 to get a stream of all file
    lines with the newline characters removed. User Stream.map/2 to lazily
    build a list of line lengths. Pass that value to Enum.max/3 to take the
    largest value from the list

    Ran an iEx test using the same large file (3.1 MB of single word lines) as
    above on lines_lengths!/1. The call and return are listed below, with the
    result returned in less than a second. Of note, the only line in the entire
    file that is more than a single word is the first line that describes the
    file - that is the return of this call:

    iex> Exercises.EnumStreamsPractice.longest_line_length!("/Users/adamphillips/Documents/Collins\ Scrabble\ Words\ (2015).txt")
    57

    See below for the contents of the one line in the file that is more than
    a single word (first, "header" line describing the file contents)
  """
  @spec longest_line_length!(String.t) :: integer
  def longest_line_length!(path) do
    path
    |> filtered_lines!()
    |> Stream.map(&String.length/1)
    |> Enum.max()
  end

  @doc """
    Take a file path and pass to filtered_lines/1 to get a stream of all file
    lines with the newline characters removed. Pass the stream to Enum.max_by/4
    to use String.length/1 to return the longest element (line)

    As above, tested in iEx with the same large, many lined file. Result was
    returned in under a second again (much faster than pure eager operation):

    iex> Exercises.EnumStreamsPractice.longest_line!("/Users/adamphillips/Documents/Collins\ Scrabble\ Words\ (2015).txt")
    "Collins Scrabble Words (2015). 276,643 words. Words only."
  """
  @spec longest_line!(String.t) :: String.t
  def longest_line!(path) do
    path
    |> filtered_lines!()
    |> Enum.max_by(&String.length/1)
  end

  @doc """
    Take a file path and pass to filtered_lines/1 to get a stream of all file
    lines with the newline characters removed. Pipe to Enum.map/2 and call
    a private function word_count/1 for each string (line). This function
    uses String.split/1 to split the line into substrings at each occurrence of
    non-leading or trailing whitespace. The resulting group of substrings is
    counted, with that number being what Enum.map/2 uses to build a list.

    As this is an eager operation being called on each line in the file and
    work being done on each line as well, my test took ~2 - 3 seconds to
    finish. But the results from iEx:

    iex> Exercises.EnumStreamsPractice.words_per_line!("/Users/adamphillips/Documents/Collins\ Scrabble\ Words\ (2015).txt")
    [8, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...]

    * After the header line, which is the only line in the file with more than
    one word, there's a blank line - the 0 in the truncated list above. All
    other lines have exactly one word
  """
  @spec words_per_line!(String.t) :: [integer]
  def words_per_line!(path) do
    path
    |> filtered_lines!()
    |> Enum.map(&word_count/1)
  end

  @spec word_count(String.t) :: integer
  defp word_count(line) do
    line
    |> String.split()
    |> length()
  end
end
