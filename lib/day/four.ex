defmodule Advent.Solution.Four do
  @behaviour Advent.Solution

  @impl true
  def day_index, do: 4

  @impl true
  def solve_first(input) do
    parse_input(input)
    |> Enum.filter(fn {s1, s2} ->
      subrange?(s1, s2) or subrange?(s2, s1)
    end)
    |> Enum.count()
  end

  @impl true
  def solve_second(input) do
    parse_input(input)
    |> Enum.filter(fn {s1, s2} -> overlaps?(s1, s2) end)
    |> Enum.count()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left_range, right_range] = String.split(line, ",")

      {parse_range(left_range), parse_range(right_range)}
    end)
  end

  defp parse_range(range) do
    [start, finish] = String.split(range, "-", trim: true)

    with {start_int, ""} <- Integer.parse(start),
         {finish_int, ""} <- Integer.parse(finish) do
      {start_int, finish_int}
    else
      _ -> raise ArgumentError, message: "Not an integer: #{inspect(start)} or #{inspect(finish)}"
    end
  end

  defp subrange?({x1, x2}, {y1, y2}) do
    x1 <= y1 and x2 >= y2
  end

  defp overlaps?({x1, x2}, {y1, y2}) do
    x1 <= y2 and y1 <= x2
  end
end
