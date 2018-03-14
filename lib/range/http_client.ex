defmodule Pwned.Range.HTTPClient do
  @moduledoc false
  @behaviour Pwned.Range

  def get(head) do
    case HTTPoison.get("https://api.pwnedpasswords.com/range/#{head}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      _ ->
        :error
    end
  end
end
