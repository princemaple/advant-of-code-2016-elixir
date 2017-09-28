defmodule AoC.Util do
  def fetch_input(day) do
    {:ok, %{body: body}} = HTTPoison.get(
      "http://adventofcode.com/2016/day/#{day}/input",
      [{"Cookie", "session=#{session()}"}]
    )
    String.trim(body)
  end

  defp session, do: System.get_env("SESSION")
end
