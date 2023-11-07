defmodule BackendWeb.WorkingTimeControllerTest do
  use BackendWeb.ConnCase

  import Backend.UsersFixtures
  import Backend.WorkingTimesFixtures

  alias Backend.Users.User
  alias Backend.WorkingTimes.WorkingTime
  @user_create %{
    username: "redaa",
    email: "email@amail.com",
    role: "manager"
  }
  @create_attrs %{

    start_time: "2023-10-23 07:55:00",
    status: true,
    end_time: "2023-10-23 07:55:00"
  }
  @update_attrs %{
    start_time: ~N[2023-10-24 07:55:00],
    status: false,
    end_time: ~N[2023-10-24 07:55:00]
  }
  @invalid_attrs %{start_time: nil, status: nil, end_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all working_times", %{conn: conn} do
      conn = get(conn, ~p"/api/workingtimes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create working_time" do
    setup [:create_user]

    test "renders working_time when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @create_attrs)
      assert %{"id" => wtid} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{id}/#{wtid}")

      assert %{
               "id" => ^wtid,
               "end_time" => "2023-10-23T07:55:00",
               "start_time" => "2023-10-23T07:55:00",
               "status" => true
             } = json_response(conn, 200)["data"]
    end
    test "renders errors when data is invalid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working_time" do
    setup [:create_working_time]

    test "renders working_time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      IO.inspect(user_id)
      conn = put(conn, ~p"/api/workingtimes/#{id}", working_time: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/workingtimes/#{user_id}/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-24T07:55:00",
               "start_time" => "2023-10-24T07:55:00",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = put(conn, ~p"/api/workingtimes/#{working_time}", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_time" do
    setup [:create_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      conn = delete(conn, ~p"/api/workingtimes/#{id}")
      assert response(conn, 204)
      conn = get(conn, ~p"/api/workingtimes/#{user_id}/#{id}")
      assert response(conn, 404)


    end
  end

  defp create_working_time(_) do
    user = user_fixture()
    %{user: user}
    working_time = working_time_fixture(user.id)
    %{working_time: working_time}
  end
  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
