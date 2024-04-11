defmodule SFDCQuery.View.Printer do
  alias SFDCQuery.Query

  @spec line(integer()) :: :ok
  def line(size \\ 80), do: separator(size) |> IO.puts()

  @spec separator(integer()) :: String.t()
  def separator(size \\ 80), do: String.pad_trailing("", size, "-")

  @spec print(any(), Query.t()) :: :ok
  def print(value, query), do: print(value, query, [])

  @spec print(Query.t(), String.t() | {atom(), String.t()}, Keyword.t()) :: :ok
  def print({_key, value}, query, opts), do: print(value, query, opts)

  def print(value, query, opts) do
    break()

    IO.puts(query.soql)

    line(Keyword.get(opts, :line_size) || String.length(query.soql) + 10)

    IO.puts(value)
  end

  @spec break() :: :ok
  def break, do: IO.puts("")
end
