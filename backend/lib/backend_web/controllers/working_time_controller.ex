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

  def create_working_time(conn, %{"userID" => id}) do
    {user_id, ""} = Integer.parse(id)
    params = Map.merge(%{"user_id" => user_id}, conn.body_params["working_time"])

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(params) do
      conn
      |> put_status(:created)
      |> render(:show, working_time: working_time)
    end
  end

  def get_one_working_time(conn, %{"userID" => user_id, "id" => id}) do
    
    try do
      {user_id_int, ""} = Integer.parse(user_id)
      {working_time_id_int, ""} = Integer.parse(id)
      working_time = Repo.get_by!(WorkingTime, user_id: user_id_int, id: working_time_id_int)

      render(conn, :show, working_time: working_time)
    rescue
      Ecto.NoResultsError -> send_resp(conn , 404 , "No result found for user id : #{user_id} and working time id : #{id} ")
    end
  end

  def update_working_time(conn, %{"id" => id, "working_time" => working_time_params}) do
    try do
      working_time = WorkingTimes.get_working_time!(id)
      
      with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.update_working_time(working_time, working_time_params) do
        render(conn, :show, working_time: working_time)
      end
    rescue
      Ecto.NoResultsError -> send_resp(conn , 404 ,"No user found for user id :#{id} ")
    end
  end

  def delete_working_time(conn, %{"id" => id}) do
    try do  
      working_time = WorkingTimes.get_working_time!(id)

      with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError -> send_resp(conn , 404 , "No working time found for id : #{id}")
    end
  end
end