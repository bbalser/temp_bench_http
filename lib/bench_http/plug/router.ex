defmodule BenchHttp.Plug.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello/:name" do
    send_resp(conn, 200, "Hello #{conn.params["name"]}")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

end
