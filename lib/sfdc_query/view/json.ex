defmodule SFDCQuery.View.JSON do
  @behaviour SFDCQuery.View.Behaviour

  alias SFDCQuery.Query

  alias SFDCQuery.View.Printer

  @impl true
  def show({:error, _} = error), do: error

  def show({:ok, %Query{} = query} = params) do
    params
    |> SFDCQuery.Parser.JSON.parse()
    |> then(fn {:ok, json} -> Jason.Formatter.pretty_print(json) end)
    |> Printer.print(query)
  end
end
