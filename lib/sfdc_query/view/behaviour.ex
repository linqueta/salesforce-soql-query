defmodule SFDCQuery.View.Behaviour do
  alias SFDCQuery.Query

  @callback show({:ok, Query.t()} | {:error, any()}) :: :ok
end
