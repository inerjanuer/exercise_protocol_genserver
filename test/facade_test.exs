defmodule FacadeTest do
  use ExUnit.Case
  doctest Facade

  test "facade start server" do
    #{:ok, message} = Facade.start_link("Nuevo mensaje")
    message = Facade.createMessage(:one, "primer mensaje")
    assert Facade.Util.startServer(message) == "primer mensaje"
    #assert Facade.get_value(message) == "Nuevo mensaje"
  end

  test "facade stop server" do
    message = Facade.createMessage(:one, "primer mensaje")
    assert Facade.Util.stopServer(message) == :ok
  end
end
