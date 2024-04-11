defmodule SFDCQuery.Parser.CSV do
  @behaviour SFDCQuery.Parser.Behaviour

  alias SFDCQuery.Query

  @impl true
  def parse({:error, _} = error), do: error

  def parse({:ok, %Query{fields: fields, records: records}}) do
    header = Enum.join(fields, ",")
    rows = Enum.map(records, fn record -> build_row(fields, record) end)

    {:ok, Enum.join([header | rows], "\n")}
  end

  defp build_row(fields, record),
    do: Enum.map_join(fields, ",", fn field -> record[String.to_atom(field)] end)
end
