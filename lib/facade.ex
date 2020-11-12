defmodule Facade do
  use GenServer

  defmodule Message do
    defstruct [name: :data, message: "message"]
  end

  defprotocol Util do
    def startServer(var)
    def stopServer(var)
  end

  defimpl Util, for: Message  do
    def startServer(var) do
      IO.puts("start...")
      Facade.start_link(var.name)
      Facade.add(var.name, var.message)
      Facade.get(var.name, var.message)
    end

    def stopServer(var) do
      IO.puts("stop..")
      Facade.stop(var.name)
    end
  end

  def start_link(name , params \\ []) do
    GenServer.start_link(__MODULE__, :ok,  params ++ [name: name])
  end

  def init(:ok), do: {:ok, %{}}

  def stop(name), do: GenServer.cast(name, :stop)

  def add(name, data) do
    GenServer.call(name, {:add, data})
  end

  def handle_call({:add, data}, _from, state) do
    {:reply, data, Map.put(state, data, data)}
  end

  def get(name, rut) do
    GenServer.call(name, {:get, rut})
  end

  def handle_call({:get, rut}, _from, state) do
    {:reply, Map.get(state, rut), state}
  end

  def handle_cast(:stop, state), do: {:stop, :normal, state}
end
