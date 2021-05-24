# NeuralNetwork

A simple neural network example trained to recognise images from MNIST dataset built as a part of School of Elixir 2021 Spring edition. The comments in code describe exercises we did:
* Build a parser for preparing data
* Build a model for a neural network with one hidden layer by designing parameters initialisation and appropriate activation and loss functions
* Write unit tests for the model and the parser 

## Running
To see it in action, you can run `NeuralNetwork.run` to train the network (the weights' matrices and biases' vectors). Without `EXLA` the training process may take some time. You can access already trained parameters by calling `Parser.get_pretrained_params()`. Once you have the parameters you can use the `Model.predict` function to create prediction for a given input. After that you can compare the difference between labels and probability distibution returned by the network.

## Example usage
```elixir
{images, labels} = NeuralNetwork.Parser.download()
params = NeuralNetwork.Parser.get_pretrained_params()

# take one batch
images_batch = hd(images)
labels_batch = hd(labels)

NeuralNetwork.Model.predict(params, images_batch, labels_batch)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/neural_network](https://hexdocs.pm/neural_network).

