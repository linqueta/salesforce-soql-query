defmodule SalesforceSoqlQuery.ConfigTest do
  use ExUnit.Case

  alias SalesforceSoqlQuery.Config

  describe "new/1" do
    test "returns a new default configuration struct with the given arguments" do
      System.put_env("SALESFORCE_SOQL_QUERY_INSTANCE_URL", "INSTANCE_URL_ENV")
      System.put_env("SALESFORCE_SOQL_QUERY_ACCESS_TOKEN", "ACCESS_TOKEN_ENV")
      System.put_env("SALESFORCE_SOQL_QUERY_REFRESH_TOKEN", "REFRESH_TOKEN_ENV")
      System.put_env("SALESFORCE_SOQL_QUERY_VERSION", "50.0")

      assert %Config{
               instance_url: "INSTANCE_URL_ENV",
               access_token: "ACCESS_TOKEN_ENV",
               refresh_token: "REFRESH_TOKEN_ENV",
               version: "50.0",
               logger: Logger,
               log_enabled: false
             } = Config.new()
    end

    test "returns a new configuration struct with the given arguments" do
      assert %Config{
               instance_url: "MY_INSTANCE_URL",
               access_token: "MY_ACCESS_TOKEN",
               refresh_token: "MY REFRESH TOKEN",
               version: "48.0",
               logger: Logger,
               log_enabled: true
             } =
               Config.new(%{
                 instance_url: "MY_INSTANCE_URL",
                 access_token: "MY_ACCESS_TOKEN",
                 refresh_token: "MY REFRESH TOKEN",
                 version: "48.0",
                 logger: Logger,
                 log_enabled: true
               })
    end
  end
end
