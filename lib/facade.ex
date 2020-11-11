defmodule Facade do
  use GenServer

  defmodule Message do
    defstruct [:name, :message]
  end

  defprotocol Util do
    def startServer(var)
    def stopServer(var)
  end

  defimpl Util, for: Message  do
    def startServer(var) do
      #IO.inspect(var)
      IO.puts("start...")
      {:ok, pid } = Facade.start_link(var.name)
      Facade.add(var.name, var.message)
      Facade.get(var.name, var.message)
    end

    def stopServer(var) do
      #IO.inspect(var)
      IO.puts("stop..")
      Facade.stop(var.name)
    end
  end

  def createMessage(name, message) do
    %Message{name: name, message: message}
  end


  #def readSystemConfigFile() do
  #  try do
  #    Process.sleep(50)
  #    IO.puts("Config files OK!")
  #  rescue
  #    _ -> IO.puts("Error")
  #  end
  #end

  def start_link(name , params \\ []) do
    GenServer.start_link(__MODULE__, :ok,  params ++ [name: name])
  end

  def init(state), do: {:ok, %{}}

  def stop(name) do
    GenServer.cast(name, :stop)
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

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






  #def add(pid, message) do
  #  GenServer.cast(pid, {:system, message})
  #end
  #def handle_call({:system, message}, state) do
  #  {:noreply, [message | state]}
  #end
  #def init() do

   # IO.puts("Initializing")
    #GenServer.start_link(__MODULE__, initial_value)
  #end

  #def initializeContext() do
  #  IO.puts("Initializing context")
  #end
#
  #def destroy() do
  #  IO.puts("Destroying")
  #end
#
#
  #def shutdown() do
  #  IO.puts("Shutdown down...")
  #end
end
