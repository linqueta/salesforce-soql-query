defmodule SFDCQuery.View.Printer do
  alias SFDCQuery.Query

  @spec line() :: :ok
  def line, do: String.pad_trailing("", 80, "-") |> IO.puts()

  @spec print(Query.t(), String.t() | {atom(), String.t()}) :: :ok
  def print({_key, value}, query), do: print(value, query)
  def print(value, query) do
    break()
    IO.puts(query.soql)
    line()
    IO.puts(value)
  end

  @spec break() :: :ok
  def break, do: IO.puts("")
end
