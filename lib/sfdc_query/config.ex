defmodule SFDCQuery.Config do
  @moduledoc """
  The configuration of the SFDCQuery library.
  """

  defstruct [:instance_url, :access_token, :refresh_token, :version, :logs]

  @type t :: %__MODULE__{
          instance_url: String.t() | nil,
          access_token: String.t() | nil,
          refresh_token: String.t() | nil,
          version: String.t(),
          logs: boolean() | nil
        }

  @spec new(%{
          required(:instance_url) => String.t(),
          required(:access_token) => String.t(),
          optional(:refresh_token) => String.t(),
          required(:version) => String.t() | integer(),
          optional(:logs) => boolean()
        }) :: SFDCQuery.Config.t()
  def new(%{instance_url: instance_url, access_token: access_token, version: version} = args \\ %{}) do
    %SFDCQuery.Config{
      instance_url: instance_url,
      access_token: access_token,
      refresh_token: args[:refresh_token],
      version: parse_version(version),
      logs: parse_boolean(args[:logs])
    }
  end

  defp parse_boolean(nil), do: false
  defp parse_boolean(val) when is_binary(val), do: String.downcase(val) == "true"
  defp parse_boolean(bool), do: bool

  defp parse_version(version) when is_integer(version), do: "#{version}.0"
  defp parse_version(version) when is_binary(version), do: version
  defp parse_version(nil), do: nil
end
