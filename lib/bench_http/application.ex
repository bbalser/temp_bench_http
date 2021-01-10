defmodule BenchHttp.Application do
  use Application

  def start(_type, _args) do
    children = [
      elli(),
      elli_handover(),
      cowboy(),
      plug_cowboy(),
      plug_elli()
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: BenchHttp.Supervisor)
  end

  defp elli do
    %{
      id: BenchHttp.Elli,
      start: {:elli, :start_link, [[callback: BenchHttp.Elli, port: 4001]]}
    }
  end

  defp elli_handover do
    %{
      id: BenchHttp.Elli.Handover,
      start: {:elli, :start_link, [[callback: BenchHttp.Elli.Handover, port: 4004]]}
    }
  end

  defp cowboy do
    dispatch =
      :cowboy_router.compile([
        {:_, [{"/hello/:name", BenchHttp.Cowboy, []}]}
      ])

    %{
      id: BenchHttp.Cowboy,
      start:
        {:cowboy, :start_clear, [:my_http_listener, [port: 4002], %{env: %{dispatch: dispatch}}]}
    }
  end

  defp plug_cowboy do
    {Plug.Cowboy, scheme: :http, plug: BenchHttp.Plug.Router, options: [port: 4003]}
  end

  defp plug_elli do
    {Plug.Elli, plug: BenchHttp.Plug.Router}
  end
end
