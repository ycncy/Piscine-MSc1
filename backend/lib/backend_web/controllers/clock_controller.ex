defmodule BackendWeb.ClockController do
  use BackendWeb, :controller

  import Ecto.Query
  alias Backend.Repo
  alias Backend.Clocks
  alias Backend.Clocks.Clock

  action_fallback(BackendWeb.FallbackController)

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def get_clocks_by_userId(conn, %{"userID" => id}) do
    {user_id_int, ""} = Integer.parse(id)

    query = from(x in Clock, where: x.user_id == ^user_id_int)

    clocks = Repo.all(query)
    render(conn, :index, clocks: clocks)
  end

  def create_clocking_time(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> render(:show, clock: clock)
    end
  end
end
