defmodule SFDCQuery.Config do
  @moduledoc """
  The configuration of the SFDCQuery library.
  """

  alias SFDCQuery.Config

  defstruct [:instance_url, :access_token, :version, :logs]

  @type t :: %__MODULE__{
          instance_url: String.t(),
          access_token: String.t(),
          version: String.t(),
          logs: boolean()
        }

  @spec new(%{
          required(:instance_url) => String.t(),
          required(:access_token) => String.t(),
          required(:version) => String.t() | integer(),
          optional(:logs) => boolean()
        }) :: t()
  def new(%{instance_url: nil}), do: raise(ArgumentError, "instance_url is required")
  def new(%{access_token: nil}), do: raise(ArgumentError, "access_token is required")
  def new(%{version: nil}), do: raise(ArgumentError, "version is required")

  def new(%{instance_url: instance_url, access_token: access_token, version: version} = args) do
    %Config{
      instance_url: instance_url,
      access_token: access_token,
      version: parse_version(version),
      logs: parse_boolean(args[:logs])
    }
  end

  defp parse_boolean(nil), do: false
  defp parse_boolean(val) when is_binary(val), do: String.downcase(val) == "true"
  defp parse_boolean(bool), do: bool

  defp parse_version(version) when is_integer(version), do: "#{version}.0"
  defp parse_version(version) when is_binary(version), do: version
end
