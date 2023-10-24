defmodule BackendWeb.WorkingTimeController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.WorkingTimes
  alias Backend.WorkingTimes.WorkingTime

  action_fallback BackendWeb.FallbackController

  def get_all_working_times(conn,  %{"userID" => user_id}) do
    {user_id_int, ""} = Integer.parse(user_id)

    query = from(x in WorkingTime, where: x.user_id == ^user_id_int)

    working_times = Repo.all(query)
    render(conn, :index, working_times: working_times)
  end

  def create_working_time(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> render(:show, working_time: working_time)
    end
  end

  def get_one_working_time(conn, %{"userID" => user_id, "id" => id}) do
    {user_id_int, ""} = Integer.parse(user_id)
    {working_time_id_int, ""} = Integer.parse(id)

    working_time = Repo.get_by(WorkingTime, user_id: user_id_int, id: working_time_id_int)

    render(conn, :show, working_time: working_time)
  end



  def update_working_time(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete_working_time(conn, %{"id" => id}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end