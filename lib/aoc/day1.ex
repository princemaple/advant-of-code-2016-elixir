defmodule AoC.Day1 do
  def solve do
    input = AoC.Util.fetch_input(1)
    commands = String.split(input, ", ")
    {x, y} = do_solve(commands, :north, {0, 0}, MapSet.new)

    [x, y] |> Enum.map(&abs/1) |> Enum.sum |> IO.inspect
  end

  defp do_solve([], _direction, coordinates, _history), do: coordinates
  defp do_solve([c | commands], direction, coordinates, history) do
    {turn_where, steps} = break_command(c)
    direction = turn(direction, turn_where)
    {coordinates, history, visited} =
      walk(coordinates, vectorize(direction, steps), history)

    if visited do
      visited
    else
      do_solve(commands, direction, coordinates, history)
    end
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

  defp walk(coordinates, {0, 0}, history),
    do: {coordinates, history, nil}
  defp walk(coordinates, distance, history) do
    {coordinates, distance} = do_walk(coordinates, distance)

    if MapSet.member?(history, coordinates) do
      {coordinates, history, coordinates}
    else
      history = MapSet.put(history, coordinates)
      walk(coordinates, distance, history)
    end
  end

  defp do_walk({x, y}, {dx, 0}) when dx > 0, do: {{x + 1, y}, {dx - 1, 0}}
  defp do_walk({x, y}, {dx, 0}) when dx < 0, do: {{x - 1, y}, {dx + 1, 0}}
  defp do_walk({x, y}, {0, dy}) when dy > 0, do: {{x, y + 1}, {0, dy - 1}}
  defp do_walk({x, y}, {0, dy}) when dy < 0, do: {{x, y - 1}, {0, dy + 1}}
end
