defmodule SFDCQuery.View.JSONTest do
  use ExUnit.Case

  alias SFDCQuery.View.JSON

  alias SFDCQuery.Query

  describe "show/1" do
    test "when errored" do
      assert {:error, "error"} = JSON.show({:error, "error"})
    end

    test "when successful" do
      records = [
        %{"Id" => "001U8000005CeutIAC", "Name" => "Amazon"},
        %{"Id" => "001U8000005cJN0IAM", "Name" => "Google"},
        %{"Id" => "", "Name" => "Microsoft"},
        %{"Id" => "001U8000005oz2rIAA", "Name" => ""}
      ]

      soql = "SELECT Id, Name From Account LIMIT 10"

      assert :ok = JSON.show({:ok, Query.new(soql, records)})
    end
  end
end
