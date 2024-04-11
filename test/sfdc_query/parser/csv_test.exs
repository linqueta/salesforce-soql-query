defmodule SFDCQuery.Parser.CSVTest do
  use ExUnit.Case

  alias SFDCQuery.Parser.CSV

  alias SFDCQuery.Query

  describe "parser/1" do
    test "when errored" do
      assert {:error, "error"} = CSV.parse({:error, "error"})
    end

    test "when successful" do
      records = [
        %{"Id" => "001U8000005CeutIAC", "Name" => "Amazon"},
        %{"Id" => "001U8000005cJN0IAM", "Name" => "Google"},
        %{"Id" => "", "Name" => "Microsoft"},
        %{"Id" => "001U8000005oz2rIAA", "Name" => ""}
      ]

      soql = "SELECT Id, Name From Account LIMIT 10"

      assert {:ok, "Id,Name\n001U8000005CeutIAC,Amazon\n001U8000005cJN0IAM,Google\n,Microsoft\n001U8000005oz2rIAA,"} =
               CSV.parse({:ok, Query.new(soql, records)})
    end
  end
end
