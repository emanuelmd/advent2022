defmodule Advent.Solution do
  @callback day_index() :: Integer.t()

  @callback solve_first(String.t()) :: String.t()
  @callback solve_second(String.t()) :: String.t()
end
