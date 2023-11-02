defmodule BackendWeb.UserControllerTest do
  use BackendWeb.ConnCase

  import Backend.UsersFixtures

  alias Backend.Users.User

  @create_attrs %{
    username: "some username",
    email: "some@mail.com",
    role: "employee"
  }
  @update_attrs %{
    username: "someupdatedusername",
    email: "someupdated@mail.com",
    role: "manager"
  }
  @invalid_attrs %{username: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some@mail.com",
               "username" => "some username",
               "role" => "employee"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "email" => "someupdated@mail.com",
               "username" => "someupdatedusername"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: %User{id: id} = user} do
      conn = delete(conn, ~p"/api/users/#{id}")
      assert response(conn, 204)
      conn = get(conn, ~p"/api/users/#{id}")
      assert json_response(conn, 404)["errors"] != %{}
    end
    test "deletes invalid user", %{conn: conn, user: %User{id: id} = user} do
      conn = delete(conn, ~p"/api/users/#{id+1}")
      assert response(conn, 404)
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
