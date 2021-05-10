defmodule Echo do
  def go() do
    pid = spawn(Echo, :loop, [])
    Process.register(pid, :echo)
    send(:echo, {self(), :hello})
    receive do
      {^pid, msg} -> IO.inspect(msg)
    end
    send(pid, :stop)
  end

  def loop() do
    receive do
      {from, msg} ->
        send(from, {self(), msg})
        loop()
      :stop -> :ok
    end
  end
end
