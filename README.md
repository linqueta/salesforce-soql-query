# SFDCQuery

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `salesforce_soql_query` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:salesforce_soql_query, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/salesforce_soql_query>.

```elixir
args = %{
  instance_url: "https://hgdata--qatest.sandbox.my.salesforce.com",
  access_token: "00D010000008qmj!AQEAQPAIrJyERIE2Ne2GR2ClOLJGHVWPBaOMRm0mLqq9bsoV03o329HBQ0KFIA2p2ox8Y9JguSVAcL9jyoyz1QdVE_oH5L4w",
  version: "60.0"
}

args = %{
  instance_url: "https://hgdata--qatest.sandbox.my.salesforce.com",
  access_token: "00D010000008qmj!AQEAQP3CfLmGwlqOC1bm1Mk26xyZiviwytiQkNNUP0SAMPdY7aq6ihRkEDudfv_F5Cm0i4EYCIMqNEi449TIgyebrh3GLble",
  version: "60.0"
}

SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, HG_Insights__HG_Match_Status__c, Website From Account LIMIT 10")
|> SFDCQuery.View.Table.show()
```
