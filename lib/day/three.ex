defmodule Advent.Solution.Three do
  alias Advent.Utils

  @behaviour Advent.Solution

  defmodule Extension do
    def build_priorities() do
      all_letters = String.downcase(Utils.alphabet()) <> Utils.alphabet()

      all_letters
      |> String.to_charlist()
      |> Enum.zip(1..String.length(all_letters))
      |> Map.new()
    end
  end

  @priorities_map Extension.build_priorities()

  def day_index, do: 3

  def solve_first(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line ->
      {left, right} =
        String.to_charlist(line)
        |> Enum.split(div(String.length(line), 2))

      MapSet.new(left)
      |> MapSet.intersection(MapSet.new(right))
      |> select_top_priority
    end)
    |> Enum.sum()
  end

  def solve_second(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [first, second, third] ->
      MapSet.new(String.to_charlist(first))
      |> MapSet.intersection(MapSet.new(String.to_charlist(second)))
      |> MapSet.intersection(MapSet.new(String.to_charlist(third)))
      |> select_top_priority()
    end)
    |> Enum.sum()
    |> to_string()
  end

  defp select_top_priority(items_symbols) do
    items_symbols
    |> Enum.map(&Map.get(@priorities_map, &1))
    |> Enum.sort(:desc)
    |> Enum.at(0)
  end
end
