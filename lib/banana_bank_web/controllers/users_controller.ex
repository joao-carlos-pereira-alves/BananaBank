defmodule BananaBankWeb.UsersController do
  use BananaBankWeb, :controller

  alias BananaBank.Users.Create
  alias BananaBank.Users.User

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Create.call(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end
end
