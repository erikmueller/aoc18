defmodule Utils do
  def read_lines(day) do
    File.read!("lib/#{day}/#{day}.data") |> String.split
  end
end
