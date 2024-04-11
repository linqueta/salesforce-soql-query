defmodule SFDCQuery.Client.Default do
  @behaviour SFDCQuery.Client.Behaviour

  alias SFDCQuery.Config

  @doc """
  Builds a new client configuration with the given arguments.
  It fetches the values from the environment variables if they are not provided.
    SFDC_QUERY_INSTANCE_URL
    SFDC_QUERY_ACCESS_TOKEN
    SFDC_QUERY_REFRESH_TOKEN
    SFDC_QUERY_VERSION
    SFDC_QUERY_LOGS_ENABLE
  """
  @impl true
  def create(args \\ %{}) do
    Config.new(%{
      instance_url: args[:instance_url] || fetch_env("SFDC_QUERY_INSTANCE_URL"),
      access_token: args[:access_token] || fetch_env("SFDC_QUERY_ACCESS_TOKEN"),
      version: args[:version] || fetch_env("SFDC_QUERY_VERSION"),
      logs: args[:logs] || fetch_env("SFDC_QUERY_LOGS_ENABLED")
    })
  end

  defp fetch_env(key) do
    case System.get_env(key) do
      "" -> nil
      value -> value
    end
  end
end
