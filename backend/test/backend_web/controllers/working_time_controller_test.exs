defmodule BackendWeb.WorkingTimeControllerTest do
  use BackendWeb.ConnCase

  import Backend.WorkingTimesFixtures

  alias Backend.WorkingTimes.WorkingTime

  @create_attrs %{
    start: ~N[2023-10-23 07:55:00],
    status: true,
    end_time: ~N[2023-10-23 07:55:00]
  }
  @update_attrs %{
    start: ~N[2023-10-24 07:55:00],
    status: false,
    end_time: ~N[2023-10-24 07:55:00]
  }
  @invalid_attrs %{start: nil, status: nil, end_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all working_times", %{conn: conn} do
      conn = get(conn, ~p"/api/working_times")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create working_time" do
    test "renders working_time when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/working_times", working_time: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/working_times/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-23T07:55:00",
               "start" => "2023-10-23T07:55:00",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/working_times", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working_time" do
    setup [:create_working_time]

    test "renders working_time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id} = working_time} do
      conn = put(conn, ~p"/api/working_times/#{working_time}", working_time: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/working_times/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-24T07:55:00",
               "start" => "2023-10-24T07:55:00",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = put(conn, ~p"/api/working_times/#{working_time}", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_time" do
    setup [:create_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: working_time} do
      conn = delete(conn, ~p"/api/working_times/#{working_time}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/working_times/#{working_time}")
      end
    end
  end

  defp create_working_time(_) do
    working_time = working_time_fixture()
    %{working_time: working_time}
  end
end
