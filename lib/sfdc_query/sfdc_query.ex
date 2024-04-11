defmodule SFDCQuery do
  @moduledoc """
  The SFDC Query library
  """

  alias SFDCQuery.Config
  alias SFDCQuery.Query
  alias SFDCQuery.RestAPI

  @doc """
  Queries SFDC having a SFDCQuery.Config and a SOQL query returning the records
  """
  @spec query(Config.t(), String.t()) :: {:ok, list(map())} | {:error, any()}
  def query(config, soql) do
    case RestAPI.query(config, soql) do
      {:ok, records} -> {:ok, Query.new(soql, records)}
      {:error, error} -> {:error, error}
    end
  end
end
