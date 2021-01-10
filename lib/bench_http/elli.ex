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

defmodule BenchHttp.Elli.Handover do
  @behaviour :elli_handler

  def init(_req, _args) do
    {:ok, :handover}
  end

  def handle(req, _args) do
    handle(:elli_request.method(req), :elli_request.path(req), req)
  end

  defp handle(:GET, ["hello", name], req) do
    body = "Hello #{name}"
    headers = [{"content-length", to_string(byte_size(body))}]
    :ok = :elli_http.send_response(req, 200, headers, body)

    {:keep_alive, ""}
  end

  def handle_event(_event, _data, _args) do
    :ok
  end

end
