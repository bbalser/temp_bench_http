elli = fn ->
   {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
   "Hello perf" = response.body
end

cowboy = fn ->
  {:ok, response} = Tesla.get("http://localhost:4002/hello/perf")
  "Hello perf" = response.body
end

plug_cowboy = fn ->
  {:ok, response} = Tesla.get("http://localhost:4003/hello/perf")
  "Hello perf" = response.body
end

plug_elli = fn ->
  {:ok, response} = Tesla.get("http://localhost:4000/hello/perf")
  "Hello perf" = response.body
end

Benchee.run(
  %{
    "elli" => elli,
    "cowboy" => cowboy,
    "plug_cowboy" => plug_cowboy,
    "plug_elli" => plug_elli
  },
  time: 30,
  memory_time: 2,
  parallel: 4
)
