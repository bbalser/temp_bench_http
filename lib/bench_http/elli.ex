defmodule BenchHttp.Elli do
  @behaviour :elli_handler

  def handle(req, _args) do
    handle(:elli_request.method(req), :elli_request.path(req), req)
  end

  defp handle(:GET, ["hello", name], _req) do
    {:ok, [], "Hello #{name}"}
  end

  def handle_event(_event, _data, _args) do
    :ok
  end
end
