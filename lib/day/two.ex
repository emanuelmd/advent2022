defmodule Advent.Solution.Two do
  @behaviour Advent.Solution

  def day_index, do: 2

  # RPS -> Rock/Paper/Scissors
  @symbol_to_rps %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors
  }

  @symbol_to_outcome %{
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win
  }

  @rps_to_points %{
    :rock => 1,
    :paper => 2,
    :scissors => 3
  }

  def solve_first(input) do
    parse_input(input)
    |> Enum.reduce(0, fn {opponent, you}, score ->
      you = @symbol_to_rps[you]
      winner = choose_winner(opponent, you)

      outcome_score =
        case winner do
          ^you -> 6
          :draw -> 3
          ^opponent -> 0
        end

      score + @rps_to_points[you] + outcome_score
    end)
    |> to_string()
  end

  def solve_second(input) do
    parse_input(input)
    |> Enum.reduce(0, fn {opponent, outcome}, total_score ->
      round_points =
        case @symbol_to_outcome[outcome] do
          :win -> 6 + @rps_to_points[loses_to(opponent)]
          :draw -> 3 + @rps_to_points[opponent]
          :lose -> 0 + @rps_to_points[wins_to(opponent)]
        end

      round_points + total_score
    end)
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [left, right] = String.split(line, " ")

    {@symbol_to_rps[left], right}
  end

  def loses_to(:rock), do: :paper
  def loses_to(:paper), do: :scissors
  def loses_to(:scissors), do: :rock

  def wins_to(:rock), do: :scissors
  def wins_to(:paper), do: :rock
  def wins_to(:scissors), do: :paper

  defp choose_winner(:paper, :rock), do: :paper
  defp choose_winner(:rock, :scissors), do: :rock
  defp choose_winner(:scissors, :paper), do: :scissors

  defp choose_winner(left, right) do
    if left == right do
      :draw
    else
      choose_winner(right, left)
    end
  end
end
