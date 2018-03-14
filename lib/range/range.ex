defmodule Pwned.Range do
  @callback get(String.t()) :: {:ok, String.t()} | :error
end
