defmodule AoC.Day3 do
  def solve do
    input = AoC.Util.fetch_input(3)

    input
    |> String.split("\n")
    |> Enum.count(&is_triangle?/1)
    |> IO.inspect
  end

  defp is_triangle?(str) do
    [a, b, c] =
      str
      |> String.split
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort

    a + b > c
  end
end
