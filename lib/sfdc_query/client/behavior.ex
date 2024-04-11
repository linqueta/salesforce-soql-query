defmodule SFDCQuery.Client.Behaviour do
  @callback create(any()) :: SFDCQuery.Config.t()
end
