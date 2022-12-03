defmodule Advent.Utils do
  def alphabet() do
    Enum.map(65..90, &:binary.encode_unsigned/1)
    |> Enum.join()
  end
end
