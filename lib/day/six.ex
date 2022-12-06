defmodule Advent.Solution.Six do
  @behaviour Advent.Solution

  @impl true
  def day_index, do: 6

  @impl true
  def solve_first(input) do
    input
    |> parse_input
    |> find_four_uniques()
  end

  @impl true
  def solve_second(input) do
    input
    |> parse_input
    |> find_four_uniques(0, 14)
  end

  defp parse_input(input) do
    input
    |> String.trim("\n")
    |> String.to_charlist()
  end

  def find_four_uniques(list, index \\ 0, desired_length \\ 4) do
    four_uniques? =
      Enum.take(list, desired_length)
      |> MapSet.new()
      |> then(fn set -> MapSet.size(set) == desired_length end)

    if four_uniques? do
      index + desired_length
    else
      find_four_uniques(Enum.drop(list, 1), index + 1, desired_length)
    end
  end
end
