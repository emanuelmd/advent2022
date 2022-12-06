defmodule Advent.Solution.Five do
  @behaviour Advent.Solution

  @instruction_regex ~r/move (?<qty>\d+) from (?<src>\d+) to (?<dest>\d+)/

  @impl true
  def day_index, do: 5

  @impl true
  def solve_first(input) do
    {crates, instructions} = parse_input(input)

    Enum.reduce(instructions, crates, &cratemover/2)
    |> top_crates()
  end

  @impl true
  def solve_second(input) do
    {crates, instructions} = parse_input(input)

    Enum.reduce(instructions, crates, fn instruction, acc ->
      cratemover(instruction, acc, 9001)
    end)
    |> top_crates()
  end

  defp top_crates(crates) do
    crates
    |> Enum.map(&List.last/1)
    |> Enum.join("")
  end

  defp parse_input(input) do
    {crate_lines, instruction_lines} =
      input
      |> String.split("\n")
      |> Enum.split_while(&(&1 != ""))

    {parse_crate_lines(crate_lines), parse_instructions(instruction_lines)}
  end

  defp cratemover(%{qty: qty, src: src, dest: dest}, crates, vsn \\ 9000) do
    {to_move, rest} =
      Enum.at(crates, src)
      |> Enum.reverse()
      |> Enum.split(qty)

    List.update_at(crates, src, fn _ -> Enum.reverse(rest) end)
    |> List.update_at(dest, fn existing ->
      # crate mover vsn
      to_append =
        if vsn == 9001 do
          Enum.reverse(to_move)
        else
          to_move
        end

      Enum.concat(existing, to_append)
    end)
  end

  defp parse_instructions(instructions) do
    Enum.reduce(instructions, [], fn
      "", acc ->
        acc

      line, acc ->
        [qty, src, dest] =
          Regex.run(@instruction_regex, line)
          |> Enum.drop(1)
          |> Enum.map(&String.to_integer/1)

        [%{qty: qty, src: src - 1, dest: dest - 1} | acc]
    end)
    |> Enum.reverse()
  end

  defp parse_crate_lines(lines) do
    stacks =
      lines
      |> Enum.slice(0, length(lines) - 1)
      |> Enum.map(&parse_crate_line/1)
      |> rotate_matrix_right()

    stacks
  end

  defp parse_crate_line(line) do
    line
    |> String.split("", trim: true)
    |> Enum.chunk_every(4)
    |> Enum.map(fn x ->
      Enum.find(x, fn c -> c != "[" and c != "]" and c != " " end)
    end)
  end

  defp rotate_matrix_right(lines) do
    Enum.reduce(0..length(lines), [], fn idx, acc ->
      new_line =
        lines
        |> Enum.map(&Enum.at(&1, idx))
        |> Enum.reject(&is_nil/1)
        |> Enum.reverse()

      [new_line | acc]
    end)
    |> Enum.reverse()
  end
end
