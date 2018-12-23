defmodule Day2 do
  def part1 do
    {twoDupeLetters, threeDupeLetters} =
      input()
      |> Enum.map(&to2xAnd3xLetterList/1)
      |> Enum.reduce({0, 0}, fn item, {acc_two, acc_three} ->
        case item do
          [2, 3] -> {acc_two + 1, acc_three + 1}
          [2] -> {acc_two + 1, acc_three}
          [3] -> {acc_two, acc_three + 1}
        end
      end)

    twoDupeLetters * threeDupeLetters
  end

  defp to2xAnd3xLetterList(id) do
    id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn letter, acc ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
    |> Map.values()
    |> Enum.uniq()
    |> Enum.filter(&(&1 === 2 || &1 === 3))
    |> Enum.sort()
  end

  defp input, do: "day2" |> Utils.read_lines()
end
