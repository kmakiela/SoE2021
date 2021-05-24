defmodule NeuralNetwork.ModelTest do
  use ExUnit.Case, async: true
  alias NeuralNetwork.Parser
  alias NeuralNetwork.Model

  setup_all do
    # Add images and labels to the context
  end

  describe "Model" do
    test "parameters intialization" do
      assert params = Model.init_random_params()

      # Check the type and size
    end

    test "softmax" do
      tensor = Nx.tensor([1,2,3,4], names: [:output])
      expected_values = [0.032058604061603546, 0.08714432269334793, 0.23688282072544098, 0.6439142227172852]
      softmax_tensor = Model.softmax(tensor)

      # Check if the values are close enough to the expected ones. Hint: to extract value from a tensor use `Nx.to_scalar/1`

      # Check if the values sum up to 1 (or close enough)
    end

    test "predict", _context = %{images: images} do
      im_1 = hd(images)
      params = Model.init_random_params()
      predictions = Model.predict(params, im_1)

      # Check correct shape
    end

    test "loss function", _context = %{images: images, labels: labels} do
      im_1 = hd(images)
      ls_1 = hd(labels)
      params = Model.init_random_params()

      # Calculate the value of loss function

      # Check type and at least on property
    end

    test "update", _context = %{images: images, labels: labels} do
      im_1 = hd(images)
      ls_1 = hd(labels)
      params = Model.init_random_params()

      updated_params = Model.update(params, im_1, ls_1)

      # Check if the shapes of parameters remained the same
    end
  end
end
