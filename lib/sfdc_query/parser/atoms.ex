defmodule SFDCQuery.Parser.Atoms do
  @behaviour SFDCQuery.Parser.Behaviour

  @impl true
  def parse({:error, _} = error), do: error

  def parse({:ok, records}),
    do: {:ok, Enum.map(records, fn record -> for {key, val} <- record, into: %{}, do: {String.to_atom(key), val} end)}
end
