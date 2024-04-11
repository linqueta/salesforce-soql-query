defmodule SFDCQuery.Query do
  defstruct [:soql, :fields, :records]

  @type t :: %__MODULE__{
          soql: String.t(),
          fields: list(String.t()),
          records: list(map())
        }

  @spec new(String.t(), list(map())) :: SFDCQuery.Query.t()
  def new(soql, records) do
    %SFDCQuery.Query{
      soql: soql,
      fields: extract_fields_from_soql(soql),
      records: Enum.map(records, &string_to_atom/1)
    }
  end

  defp string_to_atom(map), do: for({key, val} <- map, into: %{}, do: {String.to_atom(key), val})

  defp extract_fields_from_soql(soql) do
    soql
    |> String.split(~r/select/i, parts: 2)
    |> List.last()
    |> String.split(~r/from/i, parts: 2)
    |> List.first()
    |> String.split(",")
    |> Enum.map(&String.trim/1)
  end
end
