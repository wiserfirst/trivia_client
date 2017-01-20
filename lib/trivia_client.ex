defmodule TriviaClient do
  require HTTPotion

  @moduledoc """
  Documentation for TriviaClient.
  """

  @doc """
  Gets a random trivia question from http://jservice.io/

  ## Examples

      iex> TriviaClient.random 2
      [{"The name of this Army branch is also something a knight might wear",
        "Armor"},
       {"This U.S. city precedes \"brown\" in the name of a sweet, dark steamed bread",
        "Boston"}]

  """
  def random(count \\ 1) do
    "#{endpoint}random?count=#{count}"
    |> fetch()
    |> get_result
    |> Enum.map(&{&1["question"], &1["answer"]})
  end

  defp fetch(url) do
    url
    |> HTTPotion.get()
    |> Map.get(:body)
    |> Poison.decode
  end

  defp get_result({:ok, result}), do: result
  defp get_result(_), do: IO.puts "Failed to fetch trivia"

  defp endpoint, do: "http://jservice.io/api/"
end
