defmodule Pwned.Range do
  @moduledoc false
  @callback get(String.t()) :: {:ok, String.t()} | :error
end
