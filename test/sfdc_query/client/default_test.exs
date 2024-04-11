defmodule SFDCQuery.Client.DefaultTest do
  use ExUnit.Case

  alias SFDCQuery.Client.Default
  alias SFDCQuery.Config

  describe "new/1" do
    test "returns a new default configuration struct with the given arguments" do
      System.put_env("SFDC_QUERY_INSTANCE_URL", "INSTANCE_URL_ENV")
      System.put_env("SFDC_QUERY_ACCESS_TOKEN", "ACCESS_TOKEN_ENV")
      System.put_env("SFDC_QUERY_VERSION", "50.0")
      System.put_env("SFDC_QUERY_LOGS_ENABLED", "TRUE")

      assert %Config{
               instance_url: "INSTANCE_URL_ENV",
               access_token: "ACCESS_TOKEN_ENV",
               version: "50.0",
               logs: true
             } = Default.create()
    end

    test "returns a new configuration struct with the given arguments" do
      assert %Config{
               instance_url: "MY_CUSTOM_INSTANCE_URL",
               access_token: "MY_CUSTOM_ACCESS_TOKEN",
               version: "48.0",
               logs: true
             } =
               Default.create(%{
                 instance_url: "MY_CUSTOM_INSTANCE_URL",
                 access_token: "MY_CUSTOM_ACCESS_TOKEN",
                 version: "48.0",
                 logs: true
               })
    end
  end
end
