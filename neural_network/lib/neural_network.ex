defmodule NeuralNetwork do
  @moduledoc """
  Documentation for NeuralNetwork.
  """
  alias NeuralNetwork.Parser
  alias NeuralNetwork.Model

  def run do
    {images, labels} = Parser.download()
    images_200 = Enum.take(images, 200)
    labels_200 = Enum.take(labels, 200)
    Model.train(images_200, labels_200)
  end
end
