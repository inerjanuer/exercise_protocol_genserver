defmodule FacadeTest do
  use ExUnit.Case
  doctest Facade

  alias Facade.Message
  test "facade start server" do
    message = %Message{name: :iner, message: "primer mensaje"}
    assert Facade.Util.startServer(message) == "primer mensaje"
  end

  test "facade stop server" do
    message = %Message{name: :iner, message: "primer mensaje"}
    assert Facade.Util.stopServer(message) == :ok
  end

  test "initial and stop facade server" do
    message = %Message{name: :iner, message: "message"}
    assert Facade.Util.startServer(message) == "message"
    assert Facade.Util.stopServer(message) == :ok
  end

  test "multiple servers " do
    message = %Message{name: :iner, message: "message"}
    message1 = %Message{name: :iner, message: "message1"}
    message2 = %Message{name: :iner, message: "message2"}
    assert Facade.Util.startServer(message) == "message"
    assert Facade.Util.startServer(message1) == "message1"
    assert Facade.Util.startServer(message2) == "message2"
    assert Facade.Util.stopServer(message) == :ok
    assert Facade.Util.stopServer(message1) == :ok
    assert Facade.Util.stopServer(message2) == :ok
  end
end
