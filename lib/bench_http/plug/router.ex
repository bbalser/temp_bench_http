defmodule BenchHttp.Plug.Router do
  # defp plug_builder_call(conn, opts) do
  #   case(match(conn, [])) do
  #     %Plug.Conn{halted: true} = conn ->
  #       nil
  #       conn

  #     %Plug.Conn{} = conn ->
  #       case(dispatch(conn, [])) do
  #         %Plug.Conn{halted: true} = conn ->
  #           nil
  #           conn

  #         %Plug.Conn{} = conn ->
  #           conn

  #         other ->
  #           :erlang.error(
  #             RuntimeError.exception(
  #               <<"expected dispatch/2 to return a Plug.Conn, all plugs must receive a connection (conn) and return a connection"::binary(),
  #                 ", got: "::binary(), Kernel.inspect(other)::binary()>>
  #             )
  #           )
  #       end

  #     other ->
  #       :erlang.error(
  #         RuntimeError.exception(
  #           <<"expected match/2 to return a Plug.Conn, all plugs must receive a connection (conn) and return a connection"::binary(),
  #             ", got: "::binary(), Kernel.inspect(other)::binary()>>
  #         )
  #       )
  #   end
  # end

  # def match(conn, _opts) do
  #   do_match(conn, conn.method, Plug.Router.Utils.decode_path_info!(conn), conn.host)
  # end

  # def init(opts) do
  #   opts
  # end

  # defp do_match(conn, "GET", ["hello", name], _) do
  #   nil
  #   nil

  #   merge_params = fn
  #     %Plug.Conn.Unfetched{} ->
  #       %{"name" => name}

  #     fetched ->
  #       :maps.merge(fetched, %{"name" => name})
  #   end

  #   conn = Map.update!(conn, :params, merge_params)
  #   conn = Map.update!(conn, :path_params, merge_params)

  #   Plug.Router.__put_route__(conn, "/hello/:name", fn conn, opts ->
  #     _ = opts

  #     Plug.Conn.send_resp(
  #       conn,
  #       200,
  #       <<"Hello "::binary(), String.Chars.to_string(conn.params["name"])::binary()>>
  #     )
  #   end)
  # end

  # defp do_match(conn, _, _path, _) do
  #   nil
  #   nil

  #   merge_params = fn
  #     %Plug.Conn.Unfetched{} ->
  #       %{}

  #     fetched ->
  #       :maps.merge(fetched, %{})
  #   end

  #   conn = Map.update!(conn, :params, merge_params)
  #   conn = Map.update!(conn, :path_params, merge_params)

  #   Plug.Router.__put_route__(conn, "/*_path", fn conn, opts ->
  #     _ = opts
  #     Plug.Conn.send_resp(conn, 404, "not found")
  #   end)
  # end

  # def dispatch(%Plug.Conn{} = conn, opts) do
  #   start = :erlang.monotonic_time()
  #   {path, fun} = :maps.get(:plug_route, conn.private)
  #   metadata = %{conn: conn, route: path, router: BenchHttp.Plug.Router}

  #   :telemetry.execute(
  #     [:plug, :router_dispatch, :start],
  #     %{system_time: :erlang.system_time()},
  #     metadata
  #   )

  #   try do
  #     fun.(conn, opts)
  #   catch
  #     kind, reason ->
  #       duration = :erlang.-(:erlang.monotonic_time(), start)
  #       metadata = %{kind: kind, reason: reason, stacktrace: __STACKTRACE__}
  #       :telemetry.execute([:plug, :router_dispatch, :exception], %{duration: duration}, metadata)
  #       Plug.Conn.WrapperError.reraise(conn, kind, reason, __STACKTRACE__)
  #   else
  #     conn ->
  #       duration = :erlang.-(:erlang.monotonic_time(), start)
  #       metadata = %{metadata | conn: conn}
  #       :telemetry.execute([:plug, :router_dispatch, :stop], %{duration: duration}, metadata)
  #       conn
  #   end
  # end

  # def call(conn, opts) do
  #   plug_builder_call(conn, opts)
  # end

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
