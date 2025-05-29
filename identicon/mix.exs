defmodule Identicon.MixProject do
  use Mix.Project

  def project do
    [
      app: :identicon,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:egd, github: "erlang/egd", manager: :rebar3}
      # {:percept, github: "erlang/percept"}
    ]
  end

  # DEPS ARE BROKEN! Edit deps/egd/src/egd_png.erl at the bottom with this to
  # get it to work
  # create_chunk(Bin,Z) when is_list(Bin) ->
  #     create_chunk(list_to_binary(Bin),Z);
  # create_chunk(Bin,_Z) when is_binary(Bin) ->
  #     Sz = size(Bin)-4,
  #     Crc = erlang:crc32(Bin),
  #     <<Sz:32,Bin/binary,Crc:32>>.

  # % End tainted
end
