defmodule AoC.Day5 do
  def solve do
    do_solve(System.get_env("DAY5_INPUT"), 0, [], 0)
    |> Enum.reverse
    |> Enum.join
    |> IO.inspect
  end

  defp do_solve(_txt, _index, pass_chars, 8), do: pass_chars
  defp do_solve(txt, index, pass_chars, count) do
    case(
      txt <> Integer.to_string(index)
      |> :erlang.md5
      |> Base.encode16(case: :lower)
    ) do
      "00000" <> <<char :: utf8, _rest :: binary>> ->
        do_solve(txt, index + 1, [<<char>> | pass_chars], count + 1)
      _ ->
        do_solve(txt, index + 1, pass_chars, count)
    end
  end
end
