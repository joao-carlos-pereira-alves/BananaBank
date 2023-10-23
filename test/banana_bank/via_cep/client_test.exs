defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = "96402130"

      body = ~s({
        "cep": "96402-130",
        "logradouro": "",
        "complemento": "",
        "bairro": "",
        "localidade": "",
        "uf": "RS",
        "ibge": "4301602",
        "gia": "",
        "ddd": "53",
        "siafi": "8531"
      })

      expected_response =
        {:ok,
         %{
           "bairro" => "",
           "cep" => "96402-130",
           "complemento" => "",
           "ddd" => "53",
           "gia" => "",
           "ibge" => "4301602",
           "localidade" => "",
           "logradouro" => "",
           "siafi" => "8531",
           "uf" => "RS"
         }}

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
