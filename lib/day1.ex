defmodule Day1 do
  def part1, do: Enum.sum read_data()
  def part2, do: calc(read_data(), [0])

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

  defp read_data do
    File.read!("lib/day1.data") |> String.split |> Enum.map(&String.to_integer/1)
  end
end
