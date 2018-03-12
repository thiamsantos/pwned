defmodule PwnedTest do
  use ExUnit.Case
  doctest Pwned

  test "greets the world" do
    assert Pwned.hello() == :world
  end
end
