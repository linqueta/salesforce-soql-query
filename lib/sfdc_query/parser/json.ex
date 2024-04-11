defmodule SFDCQuery.Parser.JSON do
  @behaviour SFDCQuery.Parser.Behaviour

  alias SFDCQuery.Query

  @impl true
  def parse({:error, _} = error), do: error
  def parse({:ok, %Query{records: records}}), do: Jason.encode(records)
end
