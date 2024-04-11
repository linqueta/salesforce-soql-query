defmodule SFDCQuery.Parser.Behaviour do
  alias SFDCQuery.Query

  @callback parse({:ok, Query.t()} | {:error, any()}) :: {:ok, list(map())} | {:error, any()}
end
