defmodule NeuralNetwork.ModelTest do
  use ExUnit.Case, async: true
  alias NeuralNetwork.Parser
  alias NeuralNetwork.Model

  setup_all do
    # Add images and labels to the context
    {images, labels} = Parser.download()
    %{
      images: images,
      labels: labels
    }
  end

  describe "Model" do
    test "parameters intialization" do
      assert params = Model.init_random_params()

      # Check the type and size
      assert is_tuple(params)
      assert tuple_size(params) == 4

      # Check shapes of all parameters
      {w1, b1, w2, b2} = params
      assert Nx.shape(w1) == {784, 128}
      assert Nx.shape(b1) == {128}
      assert Nx.shape(w2) == {128, 10}
      assert Nx.shape(b2) == {10}

    end

    test "softmax" do
      tensor = Nx.tensor([1,2,3,4], names: [:output])
      expected_values = [0.032058604061603546, 0.08714432269334793, 0.23688282072544098, 0.6439142227172852]
      softmax_tensor = Model.softmax(tensor)

      # Check if the values are close enough to the expected ones. Hint: to extract value from a tensor use `Nx.to_scalar/1`
      for i <- 0..3 do
        assert_in_delta Nx.to_scalar(softmax_tensor[i]), Enum.at(expected_values, i), 0.001
      end

      # Check if the values sum up to 1 (or close enough)
      sum =
        softmax_tensor
        |> Nx.sum()
        |> Nx.to_scalar()
      assert sum == 1
    end

    test "predict", _context = %{images: images} do
      im_1 = hd(images)
      params = Model.init_random_params()
      predictions = Model.predict(params, im_1)

      # Check correct shape
      shape = Nx.shape(predictions)
      assert {30, 10} == shape
    end

    test "loss function", _context = %{images: images, labels: labels} do
      im_1 = hd(images)
      ls_1 = hd(labels)
      params = Model.init_random_params()

      # Calculate the value of loss function
      loss_t = Model.loss(params, im_1, ls_1)
      loss = Nx.to_scalar(loss_t)

      # Check type and at least on property
      assert is_float(loss)
      assert loss > 0
    end

    test "update", _context = %{images: images, labels: labels} do
      im_1 = hd(images)
      ls_1 = hd(labels)
      params = Model.init_random_params()

      updated_params = Model.update(params, im_1, ls_1)

      # Check if the shapes of parameters remained the same
      {w1, b1, w2, b2} = params
      {uw1, ub1, uw2, ub2} = updated_params

      assert Nx.shape(w1) == Nx.shape(uw1)
      assert Nx.shape(b1) == Nx.shape(ub1)
      assert Nx.shape(w2) == Nx.shape(uw2)
      assert Nx.shape(b2) == Nx.shape(ub2)
    end
  end
end
