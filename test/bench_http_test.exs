defmodule BenchHttpTest do
  use ExUnit.Case
  doctest BenchHttp

  test "greets the world" do
    assert BenchHttp.hello() == :world
  end
end
