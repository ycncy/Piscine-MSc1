defmodule BackendWeb.ClockController do
  use BackendWeb, :controller

  import Ecto.Query
  require Logger
  alias Backend.Repo
  alias Backend.Clocks
  alias Backend.Users.User
  alias Backend.Clocks.Clock
  alias Backend.WorkingTimes
  alias Backend.WorkingTimes.WorkingTime
  alias Time

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

  def update_clock(conn, %{"id" => id, "clock" => clock_params}) do
    case Integer.parse(id) do
      {id_int, ""} ->
        clock = Repo.get_by(Clock, user_id: id_int)

        case clock do
          nil ->
            send_resp(conn, 404, Poison.encode!(%{error: "ClockNotFound", message: "Clock not found"}))
          _ ->
            with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
              render(conn, :show, clock: clock)
            end
        end
      :error ->
        send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
    end
  end

  def check_clock(conn, %{"id" => id, "clock" => clock_params}) do
    status = Map.get(clock_params, "status")
    time = Map.get(clock_params, "time")
    compareValue = true
    case status do
      ^compareValue ->
        case Integer.parse(id) do
          {id_int, ""} ->
            clock = Repo.get_by(Clock, user_id: id_int)
            case clock do
              nil ->
                clock_params = Map.merge(%{"user_id" => id}, conn.body_params["clock"])
                with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
                  conn
                  |> put_status(:created)
                  |> render(:show, clock: clock)
                end

              _ ->
                clock_params = Map.merge(%{"user_id" => id}, conn.body_params["clock"])
                with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
                  render(conn, :show, clock: clock)
                end
            end
          :error ->
            send_resp(conn, 400, Poison.encode!(%{error: "InvalidUserID", message: "Invalid user ID format"}))
        end
      _ ->
        case Integer.parse(id) do
          {id_int, ""} ->
            clock = Repo.get_by(Clock, user_id: id_int)
            case clock do
              nil ->
                send_resp(conn, 404, Poison.encode!(%{error: "ClocksNotFound", message: "No clocks found for the user"}))
              clocks ->
              start_time = clocks.time
              {:ok, time} = NaiveDateTime.from_iso8601(time)
                IO.inspect(time)
                IO.inspect(start_time)
                working_time_params = %Backend.WorkingTimes.WorkingTime{
                status: true,
                start_time: start_time,
                end_time: NaiveDateTime.truncate(time,:second),
                user_id: id_int
              }
              Backend.Repo.insert(working_time_params)
              clock_params = Map.merge(%{"user_id" => id}, conn.body_params["clock"])
              with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
                render(conn, :show, clock: clock)
              end
            end
        end
    end
  end

end
