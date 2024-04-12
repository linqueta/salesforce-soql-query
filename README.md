# SFDCQuery

Query Salesforce data easily formatting and viewing the data as you want!

## Installation

```elixir
def deps do
  [
    {:sdfc_query, "~> 0.1.0"}
  ]
end
```

## Using

For querying Salesforce using SFDCQuery library, you will need to define a Client and if you want, you can parse or print the query response

### Default Client

SFDCQuery implements SFDCQuery.Client.Default which allow to your application pass the follow args:

- `instance_url` 
- `access_token`
- `version`
- `logs`

In case of any of those args are not passed to the function `create/1`, it'll get the values from the environment variables:

- SFDC_QUERY_INSTANCE_URL
- SFDC_QUERY_ACCESS_TOKEN
- SFDC_QUERY_VERSION
- SFDC_QUERY_LOGS_ENABLED

<br>

```elixir 
SFDCQuery.Client.Default.create(%{
  instance_url: "https://sfdc_query.my.salesforce.com",
  access_token: "MY ACCESS TOKEN",
  version: "60.0",
  logs: true
})

%SFDCQuery.Config{
  instance_url: "https://sfdc_query.my.salesforce.com",
  access_token: "MY ACCESS TOKEN",
  version: "60.0",
  logs: true
}
```

### Building your own Client

SFDCQuery defines the behaviour `SFDCQuery.Client.Behaviour` allowing you to implement your own Client. It allow you to perfom your system's business rules for fetching the credentials of the Salesforce Org

```elixir
defmodule MyApp.CustomerSFDCClient do
  @behaviour SFDCQuery.Client.Behaviour

  alias SFDCQuery.Config

  alias MyApp.Ecto

  import Ecto.Query

  @impl true
  def create(customer_id) do
    credentials = from(c in Credentials, where: c.customer_id == ^customer_id) |> Repo.one()

    Config.new(%{
      instance_url: credentials.salesforce_instance_url,
      access_token: credentials.salesforce_access_token,
      version: credentials.salesforce_version,
      logs: false
    })
  end
end
```

### Querying Salesforce

Having a Client, now you need to write the [SOQL](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm) to query the Salesforce


```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")

{:ok,
 %SFDCQuery.Query{
   soql: "SELECT Id, Name, Website From Account LIMIT 3",
   fields: ["Id", "Name", "Website"],
   records: [
     %{
       attributes: %{
         "type" => "Account",
         "url" => "/services/data/v60.0/sobjects/Account/001U8000005CeutIAC"
       },
       Name: "Page",
       Id: "001U8000005CeutIAC",
       Website: nil
     },
     %{
       attributes: %{
         "type" => "Account",
         "url" => "/services/data/v60.0/sobjects/Account/001U8000005cJN0IAM"
       },
       Name: "Nike",
       Id: "001U8000005cJN0IAM",
       Website: "https://www.nike.com/"
     },
     %{
       attributes: %{
         "type" => "Account",
         "url" => "/services/data/v60.0/sobjects/Account/001U8000005cRAnIAM"
       },
       Name: "Google",
       Id: "001U8000005cRAnIAM",
       Website: "google.com"
     }
   ]
 }}
 ```

### Parsing the response

#### Map

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.Parser.Map.parse()

{:ok,
 [
    %{
      attributes: %{
        "type" => "Account",
        "url" => "/services/data/v60.0/sobjects/Account/001U8000005CeutIAC"
      },
      Name: "Page",
      Id: "001U8000005CeutIAC",
      Website: nil
    },
    %{
      attributes: %{
        "type" => "Account",
        "url" => "/services/data/v60.0/sobjects/Account/001U8000005cJN0IAM"
      },
      Name: "Nike",
      Id: "001U8000005cJN0IAM",
      Website: "https://www.nike.com/"
    },
    %{
      attributes: %{
        "type" => "Account",
        "url" => "/services/data/v60.0/sobjects/Account/001U8000005cRAnIAM"
      },
      Name: "Google",
      Id: "001U8000005cRAnIAM",
      Website: "google.com"
    }
  ]
}
```

#### JSON

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.Parser.JSON.parse()

{:ok, "[{\"attributes\":{\"type\":\"Account\",\"url\":\"/services/data/v60.0/sobjects/Account/001U8000005CeutIAC\"},\"Name\":\"Page\",\"Id\":\"001U8000005CeutIAC\",\"Website\":null},{\"attributes\":{\"type\":\"Account\",\"url\":\"/services/data/v60.0/sobjects/Account/001U8000005cJN0IAM\"},\"Name\":\"Nike\",\"Id\":\"001U8000005cJN0IAM\",\"Website\":\"https://www.nike.com/\"},{\"attributes\":{\"type\":\"Account\",\"url\":\"/services/data/v60.0/sobjects/Account/001U8000005cRAnIAM\"},\"Name\":\"Google\",\"Id\":\"001U8000005cRAnIAM\",\"Website\":\"google.com\"}]"}
```

#### CSV

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.Parser.CSV.parse()

{:ok, "Id,Name,Website\n001U8000005CeutIAC,Page,\n001U8000005cJN0IAM,Nike,https://www.nike.com/\n001U8000005cRAnIAM,Google,google.com"}
```

### Building your own Parser

You can build your parser using the behaviour `SFDCQuery.Parser.Behaviour`

```elixir
defmodule MyApp.SFDCParser do
  @behaviour SFDCQuery.Parser.Behaviour

  alias SFDCQuery.Query

  @impl true
  def parse({:error, _} = error), do: error
  def parse({:ok, %Query{records: records}}), do: {:ok, parse_records(records)}
end
```

### Viewing the response

When debugging an Salesforce instance, it's useful to see the data in a view. To allow this, SFDCQuery allow to see the response in the terminal.

#### Table

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.View.Table.show()

SELECT Id, Name, Website From Account LIMIT 3
-------------------------------------------------------
| Id                 | Name   | Website               |
-------------------------------------------------------
| 001U8000005CeutIAC | Page   |                       |
| 001U8000005cJN0IAM | Nike   | https://www.nike.com/ |
| 001U8000005cRAnIAM | Google | google.com            |
```

#### JSON

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.View.JSON.show()

SELECT Id, Name, Website From Account LIMIT 3
-------------------------------------------------------
[
  {
    "attributes": {
      "type": "Account",
      "url": "/services/data/v60.0/sobjects/Account/001U8000005CeutIAC"
    },
    "Name": "Page",
    "Id": "001U8000005CeutIAC",
    "Website": null
  },
  {
    "attributes": {
      "type": "Account",
      "url": "/services/data/v60.0/sobjects/Account/001U8000005cJN0IAM"
    },
    "Name": "Nike",
    "Id": "001U8000005cJN0IAM",
    "Website": "https://www.nike.com/"
  },
  {
    "attributes": {
      "type": "Account",
      "url": "/services/data/v60.0/sobjects/Account/001U8000005cRAnIAM"
    },
    "Name": "Google",
    "Id": "001U8000005cRAnIAM",
    "Website": "google.com"
  }
]
```

#### CSV

```elixir
SFDCQuery.Client.Default.create(args)
|> SFDCQuery.query("SELECT Id, Name, Website From Account LIMIT 3")
|> SFDCQuery.View.CSV.show()

SELECT Id, Name, Website From Account LIMIT 3
-------------------------------------------------------
Id,Name,Website
001U8000005CeutIAC,Page,
001U8000005cJN0IAM,Nike,https://www.nike.com/
001U8000005cRAnIAM,Google,google.com
```


### Building your own View

You can build your parser using the behaviour `SFDCQuery.View.Behaviour`

```elixir
defmodule MyApp.SFDCHTMLView do
  @behaviour SFDCQuery.View.Behaviour

  alias SFDCQuery.Query

  @impl true
  def show({:error, _} = error), do: error

  def show({:ok, %Query{records: records}}) do
    build_records_html(records)

    :ok
  end
end
```
