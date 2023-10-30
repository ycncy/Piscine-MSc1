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
            send_resp(conn, 404, Poison.encode!(%{error: "UserNotFound", message: "User not found"}))
          _ ->
            query = from(x in WorkingTime, where: x.user_id == ^user_id_int)

            working_times = Repo.all(query)

            case working_times do
              _ ->
                render(conn, :index, working_times: working_times)
              :error ->
                send_resp(conn, 404, Poison.encode!(%{error: "NoResultError", message: "No working times found"}))
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
  end

  def get_list_working_times(conn, _params) do
    query = from(x in WorkingTime, select: x)

    working_times = Repo.all(query)

    case working_times do
      [] ->
        render(conn, :index, working_times: working_times)
      _ ->
        send_resp(conn, 404, Poison.encode!(%{error: "NoResultError", message: "No working times found"}))
    end
  end

  def create_working_time(conn, %{"userID" => user_id}) do
    case Integer.parse(user_id) do
      {user_id_int, _} ->
        case Repo.get(User, user_id_int) do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "UserNotFound", message: "User not found"}))
          _ ->
            params = Map.merge(%{"user_id" => user_id}, conn.body_params["working_time"])

            with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(params) do
              conn
              |> put_status(:created)
              |> render(:show, working_time: working_time)
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
    {user_id, ""} = Integer.parse(user_id)
  end

  def get_one_working_time(conn, %{"userID" => user_id, "id" => id}) do
    case Integer.parse(user_id) do
      {user_id_int, ""} ->
        case Repo.get(User, user_id_int) do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "UserNotFound", message: "User not found"}))
          _ ->
            case Integer.parse(id) do
              {working_time_id_int, ""} ->
                working_time = Repo.get_by(WorkingTime, user_id: user_id_int, id: working_time_id_int)

                case working_time do
                  nil ->
                    send_resp(conn, 404, Poison.encode!(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"}))
                  _ ->
                    render(conn, :show, working_time: working_time)
                end
              :error ->
                 send_resp(conn, 400, Poison.encode!(%{error: "InvalidWorkingTimeID", message: "Invalid working time ID format"}))
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
  end

  def update_working_time(conn, %{"id" => id, "working_time" => working_time_params}) do
    case Integer.parse(id) do
      {id_int, ""} ->
        working_time = Repo.get(WorkingTime, id_int)

        case working_time do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"}))
          _ ->
            with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
              send_resp(conn, :no_content, "")
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
  end

  def delete_working_time(conn, %{"id" => id}) do
    case Integer.parse(id) do
      {id_int, ""} ->
        working_time = Repo.get(WorkingTime, id_int)

        case working_time do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "WorkingTimeNotFound", message: "WorkingTime not found"}))
          _ ->
            with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
              send_resp(conn, :no_content, "")
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
  end
end
