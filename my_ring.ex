defmodule MyRing do

  @moduledoc """
  Start a "ring" of processes whe each processes spawns the next
  process, sends it an :ok and waits for the :ok from its spawner. The
  whoe ring is created at the same time.
  """

  def start(num) do
    start_proc(num, self())
  end


  def start_proc(0, pid), do: send(pid, :ok)
  def start_proc(num, pid) do
    npid = spawn(__MODULE__, :start_proc, [num-1, pid])
    send(npid, :ok)
    receive do :ok -> :ok end
  end

end

## :timer.tc(MyRing, :start, [1000000])
