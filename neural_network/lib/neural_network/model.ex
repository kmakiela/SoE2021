defmodule NeuralNetwork.Model do
  @moduledoc """
  Implementation of neural network
  """
  import Nx.Defn

  @doc """
  Initialize random parameters for weights and biases
  """
  defn init_random_params do
    w1 = Nx.random_normal({784, 128}, 0.0, 0.1, names: [:input, :layer])
    b1 = Nx.random_normal({128}, 0.0, 0.1, names: [:layer])
    w2 = Nx.random_normal({128, 10}, 0.0, 0.1, names: [:layer, :output])
    b2 = Nx.random_normal({10}, 0.0, 0.1, names: [:output])
    {w1, b1, w2, b2}
  end

  @doc """
  Softmax function computed only for the output layer
  """
  defn softmax(logits) do
    Nx.exp(logits) / Nx.sum(Nx.exp(logits), axes: [:output], keep_axes: true)
  end

  @doc """
  Prediction function. Does one step forward in a network with a given formula
  """
  defn predict({w1, b1, w2, b2}, batch) do
    batch
    |> Nx.dot(w1)
    |> Nx.add(b1)
    |> Nx.logistic()
    |> Nx.dot(w2)
    |> Nx.add(b2)
    |> softmax()
  end

  @doc """
  Computes the value of a loss function between given predictions and true labels
  """
  defn loss({w1, b1, w2, b2}, batch_images, batch_labels) do
    preds = predict({w1, b1, w2, b2}, batch_images)
    -Nx.sum(Nx.mean(Nx.log(preds) * batch_labels, axes: [:output]))
  end

  @doc """
  Updates weights and biases using a SGD algorithm
  """
  defn update({w1, b1, w2, b2} = params, batch_images, batch_labels) do
    {grad_w1, grad_b1, grad_w2, grad_b2} = grad(params, &loss(&1, batch_images, batch_labels))
    step = 0.01
    {
      w1 - grad_w1 * step,
      b1 - grad_b1 * step,
      w2 - grad_w2 * step,
      b2 - grad_b2 * step
    }
  end

  def train(images, labels) do
    zip = Enum.zip(images, labels) |> Enum.with_index()

    params =
      for epoch <- 1..5,
        {{images, labels}, batch} <- zip,
        reduce: init_random_params() do
          params ->
            IO.puts("epoch #{epoch}, batch #{batch}")
            update(params, images, labels)
      end
  end
end
