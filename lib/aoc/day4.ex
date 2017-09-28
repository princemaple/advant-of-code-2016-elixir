defmodule AoC.Day4 do
  def solve do
    input = AoC.Util.fetch_input(4)

    input
    |> String.split("\n")
    |> Enum.map(&parse_input/1)
    |> Enum.filter(&check/1)
    |> Enum.map(&shift/1)
    |> Enum.find(&String.contains?(&1, ["north", "pole"]))
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

  defp shift(%{
    "name" => name,
    "sector_id" => sector_id
  }) do
    rotation_count =
      sector_id
      |> String.to_integer
      |> rem(26)

    name
    |> String.to_charlist
    |> Enum.map(fn
      ?- ->
        ?\s
      char ->
        rem((char - ?a) + rotation_count, 26) + ?a
    end)
    |> IO.iodata_to_binary
    |> Kernel.<>(sector_id)
  end
end
