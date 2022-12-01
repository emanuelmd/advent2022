defmodule Advent.Solution.One do
  @behaviour Advent.Solution

  @impl Advent.Solution
  def day_index, do: 1

  @impl Advent.Solution
  def solve_first(input) do
    parse_input(input)
    |> Enum.max()
    |> to_string()
  end

  @impl Advent.Solution
  def solve_second(input) do
    parse_input(input)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
    |> to_string()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Stream.chunk_by(&(&1 == ""))
    |> Stream.reject(&(&1 == [""]))
    |> Stream.map(fn calories -> Enum.map(calories, &String.to_integer/1) |> Enum.sum() end)
    |> Enum.to_list()
  end
end
