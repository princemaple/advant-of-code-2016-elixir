defmodule AoC.Day4 do
  def solve do
    input = AoC.Util.fetch_input(4)

    input
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
    |> Enum.filter(&check/1)
    |> Enum.reduce(0, &sector_id_sum/2)
    |> IO.inspect
  end

  defp parse_input(str) do
    ~r/
      ^
      (?<name>(?:[a-z]+-)+)
      (?<sector_id>\d+)
      \[
        (?<checksum>[a-z]+)
      \]
      $
    /x
    |> Regex.named_captures(str)
  end

  defp check(%{
    "name" => name,
    "checksum" => checksum
  }) do
    name
    |> String.replace("-", "")
    |> String.split("", trim: true)
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {k, v} -> {-length(v), k} end)
    |> Enum.sort
    |> Enum.take(5)
    |> Enum.map(&elem(&1, 1))
    |> Enum.join
    == checksum
  end

  defp sector_id_sum(%{"sector_id" => sector_id}, sum) do
    sum + String.to_integer(sector_id)
  end
end
