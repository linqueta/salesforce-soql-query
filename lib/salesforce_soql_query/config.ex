defmodule SalesforceSoqlQuery.Config do
  @moduledoc """
  The configuration of the SalesforceSoqlQuery library.
  """

  @default_version "47.0"

  defstruct [:instance_url, :access_token, :refresh_token, :version, :logger, :log_enabled]

  @type t :: %__MODULE__{
          instance_url: String.t() | nil,
          access_token: String.t() | nil,
          refresh_token: String.t() | nil,
          version: String.t(),
          logger: Logger.t() | nil,
          log_enabled: boolean() | nil
        }

  @doc """
  Builds a new configuration struct with the given arguments.
  It fetches the values from the environment variables if they are not provided.
    SALESFORCE_SOQL_QUERY_INSTANCE_URL
    SALESFORCE_SOQL_QUERY_ACCESS_TOKEN
    SALESFORCE_SOQL_QUERY_REFRESH_TOKEN
    SALESFORCE_SOQL_QUERY_VERSION

  By default, the version is set to 47.0 and the logger is disabled
  """
  @spec new(%{
          optional(:instance_url) => String.t(),
          optional(:access_token) => String.t(),
          optional(:refresh_token) => String.t(),
          optional(:version) => String.t() | integer(),
          optional(:logger) => Logger.t(),
          optional(:log_enabled) => boolean()
        }) :: SalesforceSoqlQuery.Config.t()
  def new(args \\ %{}) do
    %SalesforceSoqlQuery.Config{
      instance_url: args[:instance_url] || fetch_env("SALESFORCE_SOQL_QUERY_INSTANCE_URL"),
      access_token: args[:access_token] || fetch_env("SALESFORCE_SOQL_QUERY_ACCESS_TOKEN"),
      refresh_token: args[:refresh_token] || fetch_env("SALESFORCE_SOQL_QUERY_REFRESH_TOKEN"),
      version: parse_version(args[:version]) || fetch_env("SALESFORCE_SOQL_QUERY_VERSION") || @default_version,
      logger: args[:logger] || Logger,
      log_enabled: args[:log_enabled] || false
    }
  end

  defp fetch_env(key) do
    case System.get_env(key) do
      "" -> nil
      value -> value
    end
  end

  defp parse_version(version) when is_integer(version), do: "#{version}.0"
  defp parse_version(version) when is_binary(version), do: version
  defp parse_version(nil), do: nil
end
