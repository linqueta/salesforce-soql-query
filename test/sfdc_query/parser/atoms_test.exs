defmodule SFDCQuery.Parser.AtomsTest do
  use ExUnit.Case

  alias SFDCQuery.Parser.Atoms

  describe "parser/1" do
    test "when errored" do
      assert {:error, "error"} = Atoms.parse({:error, "error"})
    end

    test "when successful" do
      records = [
        %{"Id" => "001U8000005CeutIAC"},
        %{"Id" => "001U8000005cJN0IAM"},
        %{"Id" => "001U8000005cRAnIAM"},
        %{"Id" => "001U8000005oz2rIAA"}
      ]

      assert {:ok,
              [
                %{Id: "001U8000005CeutIAC"},
                %{Id: "001U8000005cJN0IAM"},
                %{Id: "001U8000005cRAnIAM"},
                %{Id: "001U8000005oz2rIAA"}
              ]} = Atoms.parse({:ok, records})
    end
  end
end
