defmodule Advent do
  @solution_by_days [One, Two, Three, Four, Five, Six]
                    |> Enum.map(&Module.concat([Advent.Solution, &1]))

  def run(day \\ 1)

  def run(:all) do
    Enum.each(1..25, &Advent.run(&1))
  end

  def run(day) when is_integer(day) do
    solution_module = Enum.find(@solution_by_days, fn module -> module.day_index == day end)

    if not is_nil(solution_module) do
      input = read_day_input(to_string(day))

      result_one =
        input
        |> solution_module.solve_first()
        |> to_string

      IO.puts("Day #{day} - first solution: #{result_one}")

      result_two =
        input
        |> solution_module.solve_second
        |> to_string()

      IO.puts("Day #{day} - second solution: #{result_two}")
    else
      IO.puts("Day #{day} - missing")
    end
  end

  def read_day_input(filename) do
    [File.cwd!(), "input", filename <> ".txt"]
    |> Path.join()
    |> File.read!()
  end
end
