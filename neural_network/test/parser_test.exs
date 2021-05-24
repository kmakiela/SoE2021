defmodule NeuralNetwork.ParserTest do
  use ExUnit.Case, async: true
  alias NeuralNetwork.Parser

  describe "Parser" do
    setup do
      %{
        images_path:  "train-images-idx3-ubyte.gz",
        labels_path:  "train-labels-idx1-ubyte.gz"
      }
    end

    test "Download test", context = %{images_path: images_path, labels_path: labels_path} do
      assert {images, labels} = Parser.download()
      assert {images_2, labels_2} = Parser.download(images_path, labels_path)

      assert images == images_2
      assert labels == labels_2

      # Assert that both images and labels are lists and their size is the same
    end
  end
end
