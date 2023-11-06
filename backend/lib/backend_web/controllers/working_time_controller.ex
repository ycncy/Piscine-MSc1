defmodule BackendWeb.WorkingTimeController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.WorkingTimes
  alias Backend.WorkingTimes.WorkingTime
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def get_all_working_times(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
          _ ->
            query = from(x in WorkingTime, where: x.user_id == ^user_id_int)

            IO.inspect(query)

            with working_times <- Repo.all(query) do
              conn
              |> put_status(200)
              |> json(working_times)
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def get_list_working_times(conn, _params) do
    query = from(x in WorkingTime, select: x)

    with working_times <- Repo.all(query) do
      conn
      |> put_status(200)
      |> json(working_times)
    end
  end

  def create_working_time(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
          _ ->
            params = Map.merge(%{"user_id" => user_id}, conn.body_params["working_time"])

            with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(params) do
              conn
              |> put_status(201)
              |> json(working_time)
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def get_one_working_time(conn, %{"userID" => user_id, "id" => id}) do
    case Integer.parse(user_id) do
      {user_id_int, ""} ->
        case Repo.get(User, user_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "UserNotFound", message: "User not found"})
          _ ->
            case Integer.parse(id) do
              {working_time_id_int, ""} ->
                case Repo.get_by(WorkingTime, user_id: user_id_int, id: working_time_id_int) do
                  nil ->
                    conn
                    |> put_status(404)
                    |> json(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"})
                  working_time ->
                    conn
                    |> put_status(200)
                    |> json(working_time)
                end
              :error ->
                conn
                |> put_status(400)
                |> json(%{error: "InvalidWorkingTimeID", message: "Invalid working time ID format"})
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidUserID", message: "Invalid user ID format"})
    end
  end

  def update_working_time(conn, %{"id" => id, "working_time" => working_time_params}) do
    case Integer.parse(id) do
      {id_int, ""} ->
        case Repo.get(WorkingTime, id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"})
          working_time ->
            with {:ok, %WorkingTime{} = updated_working_time} <- WorkingTimes.update_working_time(working_time, working_time_params) do
              conn
              |> put_status(200)
              |> json(updated_working_time)
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidWorkingTimeID", message: "Invalid working time ID format"})
    end
  end

  def delete_working_time(conn, %{"id" => id}) do
    case Integer.parse(id) do
      {id_int, ""} ->
        case Repo.get(WorkingTime, id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"})
          working_time ->
            with {:ok, _} <- WorkingTimes.delete_working_time(working_time) do
              conn
              |> put_status(204)
              |> json(%{})
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidWorkingTimeID", message: "Invalid working time ID format"})
    end
  end
end
