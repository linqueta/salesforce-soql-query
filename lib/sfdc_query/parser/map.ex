defmodule SFDCQuery.Parser.Map do
  @behaviour SFDCQuery.Parser.Behaviour

  alias SFDCQuery.Query

  @impl true
  def parse({:error, _} = error), do: error
  def parse({:ok, %Query{records: records}}), do: {:ok, records}
end
