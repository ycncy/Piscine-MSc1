defmodule BackendWeb.WorkingTimeControllerTest do
  use BackendWeb.ConnCase

  import Backend.UsersFixtures
  import Backend.WorkingTimesFixtures

  alias Backend.Users.User
  alias Backend.WorkingTimes.WorkingTime
  @auth %{
    email: "administrator@timemanager.com",
    password: "administrator"
  }
  @create_attrs %{

    start_time: "2023-10-23 07:55:00",
    end_time: "2023-10-23 07:55:00"
  }
  @update_attrs %{
    start_time: ~N[2023-10-24 07:55:00],
    end_time: ~N[2023-10-24 07:55:00]
  }
  @invalid_attrs %{start_time: nil, end_time: nil}


  describe "create working_time when not connected" do
    setup [:create_user]

    test "renders working_time when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @create_attrs)
      assert response(conn, 403) != %{}
    end
    test "renders errors when data is invalid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @invalid_attrs)
      assert response(conn, 403) != %{}
    end
  end

  describe "create working_time when connected" do
    setup [:create_user, :create_admin]

    test "renders working_time when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/authentication/login", user: @auth)
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @create_attrs)
      assert %{"id" => wtid} = json_response(conn, 201)

      conn = get(conn, ~p"/api/workingtimes/#{id}/#{wtid}")

      assert %{
               "id" => ^wtid,
               "end_time" => "2023-10-23T07:55:00",
               "start_time" => "2023-10-23T07:55:00"
             } = json_response(conn, 200)
    end
    test "renders errors when data is invalid", %{conn: conn, user: %User{id: id} = user} do
      conn = post(conn, ~p"/api/authentication/login", user: @auth)
      conn = post(conn, ~p"/api/workingtimes/#{id}", working_time: @invalid_attrs)
      assert response(conn, 422) != %{}
    end
  end

  describe "update working_time when not connected" do
    setup [:create_working_time]

    test "renders working_time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      conn = put(conn, ~p"/api/workingtimes/#{id}", working_time: @update_attrs)
      assert response(conn, 403) != %{}

    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = put(conn, ~p"/api/workingtimes/#{working_time}", working_time: @invalid_attrs)
      assert response(conn, 403) != %{}
    end
  end

  describe "update working_time when connected" do
    setup [:create_working_time , :create_admin]

    test "renders working_time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      conn = post(conn, ~p"/api/authentication/login", user: @auth)
      conn = put(conn, ~p"/api/workingtimes/#{id}", working_time: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, ~p"/api/workingtimes/#{user_id}/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-24T07:55:00",
               "start_time" => "2023-10-24T07:55:00"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = post(conn, ~p"/api/authentication/login", user: @auth)
      conn = put(conn, ~p"/api/workingtimes/#{working_time}", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_time when not connected" do
    setup [:create_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      conn = delete(conn, ~p"/api/workingtimes/#{id}")
      assert response(conn, 403) != %{}


    end
  end

  describe "delete working_time when connected" do
    setup [:create_working_time , :create_admin]

    test "deletes chosen working_time", %{conn: conn, working_time: %WorkingTime{id: id,user_id: user_id} = working_time} do
      conn = post(conn, ~p"/api/authentication/login", user: @auth)
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
  defp create_admin(_) do
    user = admin_fixture()
    %{user: user}
  end
end
