defmodule BenchHttp.Cowboy do
  def init(req, state) do
    name = :cowboy_req.binding(:name, req)
    req = :cowboy_req.reply(200, %{}, "Hello #{name}", req)
    {:ok, req, state}
  end
end
