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
    render(conn, :index, clocks: clocks)
  end

  def get_clocks_by_userId(conn, %{"userID" => id}) do
    try do
      {user_id_int, ""} = Integer.parse(id)

      query = from(x in Clock, where: x.user_id == ^user_id_int)

      clocks = Repo.all(query)

      if length(clocks) == 0 do
        user = Repo.get_by!(User, id: user_id_int)
      end

      render(conn, :index, clocks: clocks)
    rescue
      Ecto.NoResultsError -> send_resp(conn, 404, Poison.encode!(%{error: "NoResultError", message: "User not found"}))
    end
  end

  def create_clocking_time(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> render(:show, clock: clock)
    end
  end
end
