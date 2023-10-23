defmodule BackendWeb.UserController do
  import Ecto.Query
  use BackendWeb, :controller

  alias Backend.Repo

  def get_user_by_identifiers(conn, _params) do
    users = Repo.all(User)

    conn
    |> put_status(:ok)
    |> json(users)
  end
end
