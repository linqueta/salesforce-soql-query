defmodule SFDCQuery.View.Table do
  @behaviour SFDCQuery.View.Behaviour

  alias SFDCQuery.Query

  alias SFDCQuery.View.Printer

  @impl true
  def show({:error, _} = error), do: error

  def show({:ok, %Query{} = query} = params) do
    {:ok, csv} = SFDCQuery.Parser.CSV.parse(params)

    [headers | rows] = table = csv |> String.split("\n") |> Enum.map(&String.split(&1, ","))
    indexes_pad = build_indexes_pad(table)

    line_size = Enum.sum(indexes_pad) + 1 + length(indexes_pad) * 3

    table_with_pads =
      [build_row_with_pad(headers, indexes_pad)]
      |> append_list([Printer.separator(line_size)])
      |> append_list(Enum.map(rows, fn row -> build_row_with_pad(row, indexes_pad) end))
      |> Enum.join("\n")

    Printer.print(table_with_pads, query, line_size: line_size)
  end

  defp append_list(list, value), do: list ++ value

  defp build_row_with_pad(row, indexes_pad) do
    formatted =
      row
      |> Enum.with_index()
      |> Enum.map_join(" | ", fn {value, index} ->
        value
        |> String.pad_trailing(Enum.at(indexes_pad, index))
      end)

    "| " <> formatted <> " |"
  end

  defp build_indexes_pad([headers | _] = table) do
    headers
    |> Enum.with_index()
    |> Enum.map(fn {_, index} ->
      Enum.reduce(table, 0, fn row, acc ->
        value = Enum.at(row, index)
        size = (value && String.length(value)) || 0

        max(acc, size)
      end)
    end)
  end
end
