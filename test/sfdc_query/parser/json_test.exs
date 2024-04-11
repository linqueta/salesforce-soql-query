defmodule SFDCQuery.Parser.JSONTest do
  use ExUnit.Case

  alias SFDCQuery.Parser.JSON

  alias SFDCQuery.Query

  describe "parser/1" do
    test "when errored" do
      assert {:error, "error"} = JSON.parse({:error, "error"})
    end

    test "when successful" do
      records = [
        %{"Id" => "001U8000005CeutIAC", "Name" => "Amazon"},
        %{"Id" => "001U8000005cJN0IAM", "Name" => "Google"},
        %{"Id" => "", "Name" => "Microsoft"},
        %{"Id" => "001U8000005oz2rIAA", "Name" => ""}
      ]

      soql = "SELECT Id, Name From Account LIMIT 10"

      assert {:ok,
              "[{\"Id\":\"001U8000005CeutIAC\",\"Name\":\"Amazon\"},{\"Id\":\"001U8000005cJN0IAM\",\"Name\":\"Google\"},{\"Id\":\"\",\"Name\":\"Microsoft\"},{\"Id\":\"001U8000005oz2rIAA\",\"Name\":\"\"}]"} =
               JSON.parse({:ok, Query.new(soql, records)})
    end
  end
end
