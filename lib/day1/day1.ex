defmodule Day1 do
  def part1, do: Enum.sum input()
  def part2, do: calc(input(), [0])

  defp input, do: "day1" |> Utils.read_lines |> Enum.map(&String.to_integer/1)

  defp calc list, acc do
    potential_dup = Enum.reduce_while(list, acc, fn freq, frequencies ->
      [last_freq | _] = frequencies

      next_freq = last_freq + freq

      if Enum.member?(frequencies, next_freq) do
        {:halt, next_freq}
      else
        {:cont, [next_freq | frequencies]}
      end
    end)

    cond do
      is_list potential_dup -> calc(list, potential_dup)
      true -> potential_dup
    end
  end
end
