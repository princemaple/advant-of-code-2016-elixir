defmodule AoC.Day2 do
  @mapping %{
    1 => %{"U" => 1, "D" => 3, "L" => 1, "R" => 1},
    2 => %{"U" => 2, "D" => 6, "L" => 2, "R" => 3},
    3 => %{"U" => 1, "D" => 7, "L" => 2, "R" => 4},
    4 => %{"U" => 4, "D" => 8, "L" => 3, "R" => 4},
    5 => %{"U" => 5, "D" => 5, "L" => 5, "R" => 6},
    6 => %{"U" => 2, "D" => 0xA, "L" => 5, "R" => 7},
    7 => %{"U" => 3, "D" => 0xB, "L" => 6, "R" => 8},
    8 => %{"U" => 4, "D" => 0xC, "L" => 7, "R" => 9},
    9 => %{"U" => 9, "D" => 9, "L" => 8, "R" => 9},
    0xA => %{"U" => 6, "D" => 0xA, "L" => 0xA, "R" => 0xB},
    0xB => %{"U" => 7, "D" => 0xD, "L" => 0xA, "R" => 0xc},
    0xC => %{"U" => 8, "D" => 0xC, "L" => 0xB, "R" => 0xC},
    0xD => %{"U" => 0xB, "D" => 0xD, "L" => 0xD, "R" => 0xD},
  }

  def solve do
    input = AoC.Util.fetch_input(2)

    input
    |> String.split
    |> Enum.reduce(5, fn instructions, number ->
      instructions
      |> String.split("", trim: true)
      |> Enum.reduce(number, &get_in(@mapping, [&2, &1]))
      |> IO.inspect(base: :hex)
    end)
  end
end
