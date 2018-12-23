defmodule Day2 do
  def part1 do
    {two_letters, three_letters} =
      input()
      |> Enum.map(&to_2x_3x_letter_list/1)
      |> Enum.reduce({0, 0}, fn item, {acc_two, acc_three} ->
        case item do
          [2, 3] -> {acc_two + 1, acc_three + 1}
          [2] -> {acc_two + 1, acc_three}
          [3] -> {acc_two, acc_three + 1}
        end
      end)

    two_letters * three_letters
  end

  def part2 do
    combination(2, input())
    |> Enum.map(fn [string1, string2] -> String.myers_difference(string1, string2) end)
    |> Enum.reduce_while(:searching, fn item, _ ->
      case item do
        [eq: first, del: _, ins: _, eq: second] -> {:halt, first <> second}
        _ -> {:cont, :searching}
      end
    end)
  end

  # https://stackoverflow.com/questions/30585697/how-to-rewrite-erlang-combinations-algorithm-in-elixir
  defp combination(0, _), do: [[]]
  defp combination(_, []), do: []

  defp combination(n, [h | t]) do
    for(y <- combination(n - 1, t), do: [h | y]) ++ combination(n, t)
  end

  defp to_2x_3x_letter_list(id) do
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
