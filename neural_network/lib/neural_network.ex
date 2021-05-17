defmodule NeuralNetwork do
  @moduledoc """
  Documentation for NeuralNetwork.
  """
  alias NeuralNetwork.Parser

  def run do
    {images, labels} = Parser.download()
    IO.inspect([hd(images), hd(labels)])
  end
end
