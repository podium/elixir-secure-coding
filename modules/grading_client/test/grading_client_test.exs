defmodule GradingClientTest do
  use ExUnit.Case
  doctest GradingClient

  test "greets the world" do
    assert GradingClient.hello() == :world
  end
end
