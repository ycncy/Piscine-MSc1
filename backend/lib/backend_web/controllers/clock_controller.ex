defmodule BackendWeb.ClockController do
  use BackendWeb, :controller

  import Ecto.Query
  alias Backend.Repo
  alias Backend.Clocks
  alias Backend.Users.User
  alias Backend.Clocks.Clock

  action_fallback(BackendWeb.FallbackController)

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :json, clocks: clocks)
  end

  def get_clocks_by_userId(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})

          user ->
            query = from(x in Clock, where: x.user_id == ^user_id_int)
            with clocks <- Repo.all(query) do
              conn
              |> put_status(200)
              |> json(clocks)
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def create_clocking_time(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id, ""} ->
        case Repo.get(User, user_id) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})

          _ ->
            clock_params = Map.merge(%{"user_id" => user_id}, conn.body_params["clock"])

            with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
              conn
              |> put_status(201)
              |> json(clock)
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end
end
