defmodule NeuralNetworkTest do
  use ExUnit.Case, async: true

  test "simple assertion test" do
    assert x = 1
    assert x == 1
    send(self(), :hello)
    assert_received message
    assert message == :hello
  end
end
