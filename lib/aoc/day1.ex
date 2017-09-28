defmodule AoC.Day1 do
  def solve do
    input = AoC.Util.fetch_input(1)
    commands = String.split(input, ", ")
    {x, y} = do_solve(commands, :north, {0, 0})

    [x, y] |> Enum.map(&abs/1) |> Enum.sum |> IO.inspect
  end

  defp do_solve([], _direction, coordinates), do: coordinates
  defp do_solve([c | commands], direction, coordinates) do
    {turn_where, steps} = break_command(c)
    direction = turn(direction, turn_where)
    coordinates = walk(coordinates, vectorize(direction, steps))
    do_solve(commands, direction, coordinates)
  end

  defp break_command("L" <> steps), do: {:left, String.to_integer(steps)}
  defp break_command("R" <> steps), do: {:right, String.to_integer(steps)}

  defp turn(:north, :left), do: :west
  defp turn(:north, :right), do: :east

  defp turn(:south, :left), do: :east
  defp turn(:south, :right), do: :west

  defp turn(:east, :left), do: :north
  defp turn(:east, :right), do: :south

  defp turn(:west, :left), do: :south
  defp turn(:west, :right), do: :north

  defp vectorize(:north, n), do: {0, n}
  defp vectorize(:south, n), do: {0, -n}
  defp vectorize(:east, n), do: {n, 0}
  defp vectorize(:west, n), do: {-n, 0}

  defp walk({x, y}, {dx, dy}), do: {x + dx, y + dy}
end
