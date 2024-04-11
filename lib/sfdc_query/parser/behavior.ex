defmodule SFDCQuery.Parser.Behaviour do
  @callback parse({:ok, list(map())} | {:error, any()}) :: {:ok, list(map())} | {:error, any()}
end
