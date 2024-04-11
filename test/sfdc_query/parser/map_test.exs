defmodule SFDCQuery.Parser.MapTest do
  use ExUnit.Case

  alias SFDCQuery.Parser.Map

  alias SFDCQuery.Query

  describe "parser/1" do
    test "when errored" do
      assert {:error, "error"} = Map.parse({:error, "error"})
    end

    test "when successful" do
      records = [
        %{"Id" => "001U8000005CeutIAC", "Name" => "Amazon"},
        %{"Id" => "001U8000005cJN0IAM", "Name" => "Google"},
        %{"Id" => "001U8000005cRAnIAM", "Name" => "Microsoft"},
        %{"Id" => "001U8000005oz2rIAA", "Name" => ""}
      ]

      soql = "SELECT Id, Name From Account LIMIT 10"
      query = Query.new(soql, records)

      assert {:ok,
              [
                %{Id: "001U8000005CeutIAC", Name: "Amazon"},
                %{Id: "001U8000005cJN0IAM", Name: "Google"},
                %{Id: "001U8000005cRAnIAM", Name: "Microsoft"},
                %{Id: "001U8000005oz2rIAA", Name: ""}
              ]} = Map.parse({:ok, Query.new(soql, records)})
    end
  end
end
