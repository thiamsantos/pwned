defmodule Pwned do
  @moduledoc """
  Check if your password has been pwned.
  """

  @doc """
  It uses have i been pwned? to verify if a password has appeared in a data breach. In order to protect the value of the source password being searched the value is not sended through the network.

  ## Examples

      iex> Pwned.pwned?("password")
      {:ok, 3303003}

      iex> Pwned.pwned?("Z76okiy2X1m5PFud8iPUQGqusShCJhg+xiKeS91iOZw=")
      :error

  """
  def pwned?(password) do
    with {head, rest} <- hash(password),
         {:ok, response} <- get_range(head),
         {:ok, range} <- parse_response(response),
         {:ok, count} <- find_hash(range, rest),
         {:ok, parsed_count} <- parse_count(count) do
      {:ok, parsed_count}
    else
      :error -> :error
    end
  end

  defp hash(password) do
    :crypto.hash(:sha, password)
    |> Base.encode16()
    |> String.split_at(5)
  end

  defp get_range(head) do
    case HTTPoison.get("https://api.pwnedpasswords.com/range/#{head}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      _ ->
        :error
    end
  end

  defp parse_response(response) do
    parsed_response =
      response
      |> String.split("\r\n")
      |> Enum.map(fn line -> String.split(line, ":") end)

    {:ok, parsed_response}
  end

  defp find_hash(range, hash) do
    range
    |> Enum.find(fn item -> List.first(item) == hash end)
    |> handle_hash()
  end

  defp handle_hash(nil), do: :error
  defp handle_hash([_hash, count]), do: {:ok, count}

  defp parse_count(count) do
    Integer.parse(count)
    |> handle_count()
  end

  defp handle_count(nil), do: :error
  defp handle_count({count, _rest}), do: {:ok, count}
end
