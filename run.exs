elli = fn ->
  {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
  "Hello perf" = response.body
end

elli_handover = fn ->
  {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
  "Hello perf" = response.body
end

cowboy = fn ->
  {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
  "Hello perf" = response.body
end

plug_cowboy = fn ->
  {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
  "Hello perf" = response.body
end

plug_elli = fn ->
  {:ok, response} = Tesla.get("http://localhost:4001/hello/perf")
  "Hello perf" = response.body
end

if System.argv() == ["perf"] do
  Benchee.run(
    %{
      "elli" => elli,
      "elli_handover" => elli_handover,
      "cowboy" => cowboy,
      "plug_cowboy" => plug_cowboy,
      "plug_elli" => plug_elli
    },
    time: 30,
    memory_time: 2,
    parallel: 4
  )
else
  plug_elli.()
  # plug_cowboy.()
end

# {records, _result} = profile do
#   plug_elli.()
# end

# total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
# IO.inspect "total = #{total_percent}"
