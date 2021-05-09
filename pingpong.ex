###############################################################################
### File: pingpong.ex
### @author trainers@erlang-solutions.com
### @copyright 1999-2019 Erlang Solutions Ltd.
###############################################################################

defmodule Pingpong do
  def start() do
    # Start 2 processes using spawn/3 with functions init_a/0 and init_b/0 and register them as :a and :b respectively
    :ok
  end

  def stop() do
    # Send required messages to registered processes using send/2
  end

  def send(n) do
    send(:a, {:msg, :message, n})
    :ok
  end

  def init_a() do
    loop_a()
  end

  def init_b() do
    loop_b()
  end

  defp loop_a() do
    receive do
      :stop ->
        :ok

      {:msg, _msg, 0} ->
        loop_a()

      {:msg, msg, n} ->
        IO.puts("ping...")
        :timer.sleep(500)
        # Send appropriate message to the other process and enter the loop again
    after
      25000 ->
        IO.puts("Ping got bored, exiting.")
        exit(:timeout)
    end
  end

  defp loop_b() do
    receive do
      :stop ->
        :ok

      {:msg, _msg, 0} ->
        loop_b()

      {:msg, msg, n} ->
        IO.puts("pong!")
        :timer.sleep(500)
        # Send appropriate message to the other process and enter the loop again
    after
      25000 ->
        IO.puts("Pong got bored, exiting.")
        exit(:timeout)
    end
  end

end
