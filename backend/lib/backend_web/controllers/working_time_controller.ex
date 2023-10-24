defmodule BackendWeb.WorkingTimeController do
  import Ecto.Query
  use BackendWeb, :controller

  alias Backend.Repo

  def get_working_times_by_identifiers(conn, _params) do
    query_params = conn.query_params

    username = Map.get(query_params, "name")
    email = Map.get(query_params, "email")

    users = Repo.get_by(User, name: username, email: email)

    conn
    |> put_status(:ok)
    |> json(users)
  end
end