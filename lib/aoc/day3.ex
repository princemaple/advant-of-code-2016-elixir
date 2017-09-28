defmodule AoC.Day3 do
  def solve do
    input = AoC.Util.fetch_input(3)

    nums = String.split(input)

    [
      Stream.take_every(nums, 3),
      Stream.take_every(Enum.drop(nums, 1), 3),
      Stream.take_every(Enum.drop(nums, 2), 3),
    ]
    |> Stream.concat
    |> Stream.chunk(3)
    |> Enum.count(&is_triangle?/1)
    |> IO.inspect
  end

  defp is_triangle?(strs) do
    [a, b, c] =
      strs
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort

    a + b > c
  end
end
