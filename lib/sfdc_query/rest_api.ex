defmodule SFDCQuery.RestAPI do
  @moduledoc """
  The SFDC REST API implementation
  """

  alias SFDCQuery.Config

  @doc """
  Queries SFDC having a SFDCQuery.Config and a SOQL query returning the records
  """
  @spec query(Config.t(), String.t()) :: {:ok, list(map())} | {:error, any()}
  def query(config, soql) do
    config
    |> request(:get, "query", q: soql)
    |> handle()
  end

  defp request(config, method, endpoint, params) do
    Req.request(
      method: method,
      url: "#{config.instance_url}/services/data/v#{config.version}/#{endpoint}",
      headers: [{"Authorization", "Bearer #{config.access_token}"}],
      params: params
    )
  end

  defp handle({:ok, %Req.Response{status: 200, body: %{"records" => records}}}), do: {:ok, records}
  defp handle({:ok, %Req.Response{status: 400, body: body}}), do: {:error, body}
  defp handle({:error, _} = error), do: error
end
