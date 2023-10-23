defmodule BananaBank.ViaCep.ClientBehavior do
  @callback call(String.t()) :: {:ok, map()} | {:error, :atom}
end
