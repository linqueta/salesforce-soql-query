defmodule SFDCQuery.View.CSV do
  @behaviour SFDCQuery.View.Behaviour

  alias SFDCQuery.Query

  alias SFDCQuery.View.Printer

  @impl true
  def show({:error, _} = error), do: error

  def show({:ok, %Query{} = query} = params) do
    params
    |> SFDCQuery.Parser.CSV.parse()
    |> Printer.print(query)
  end
end
