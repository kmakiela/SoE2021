defmodule NeuralNetwork.Parser do
  @moduledoc """
  Module responsible for setting up data in a desirable way
  """
  @images "train-images-idx3-ubyte.gz"
  @labels "train-labels-idx1-ubyte.gz"
  @batch_size 30

  defp unzip_cache_or_download(zip) do
    base_url = 'https://storage.googleapis.com/cvdf-datasets/mnist/'
    path = Path.join("tmp", zip)

    data =
      if File.exists?(path) do
        IO.puts("Using #{zip} from tmp/\n")
        File.read!(path)
      else
        IO.puts("Fetching #{zip} from https://storage.googleapis.com/cvdf-datasets/mnist/\n")
        :inets.start()
        :ssl.start()

        {:ok, {_status, _response, data}} = :httpc.request(base_url ++ zip)
        File.mkdir_p!("tmp")
        File.write!(path, data)

        data
      end

    :zlib.gunzip(data)
  end

  def download(), do: download(@images, @labels)
  def download(images, labels) do
    <<_::32, n_images::32, n_rows::32, n_cols::32, images::binary>> =
      unzip_cache_or_download(images)

    train_images =
      images
      |> Nx.from_binary({:u, 8})
      |> Nx.reshape({n_images, n_rows * n_cols}, names: [:batch, :input])
      |> Nx.divide(255)
      |> Nx.to_batched_list(@batch_size)

    <<_::32, n_labels::32, labels::binary>> = unzip_cache_or_download(labels)

    train_labels =
      labels
      |> Nx.from_binary({:u, 8})
      |> Nx.reshape({n_labels, 1}, names: [:batch, :output])
      |> Nx.equal(Nx.tensor(Enum.to_list(0..9)))
      |> Nx.to_batched_list(@batch_size)

    {train_images, train_labels}
  end

  def get_preatrained_params() do
    {:ok, w1_bin} = File.read("w1")
    {:ok, w2_bin} = File.read("w2")
    {:ok, b1_bin} = File.read("b1")
    {:ok, b2_bin} = File.read("b2")

    w1 = Nx.from_binary(w1_bin, {:f, 32}) |> Nx.reshape({784, 128})
    w2 = Nx.from_binary(w2_bin, {:f, 32}) |> Nx.reshape({128, 10})
    b1 = Nx.from_binary(b1_bin, {:f, 32})
    b2 = Nx.from_binary(b2_bin, {:f, 32})

    {w1, b1, w2, b2}
  end
end
