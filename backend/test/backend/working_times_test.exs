defmodule Backend.WorkingTimesTest do
  use Backend.DataCase
  import Backend.UsersFixtures
  alias Backend.WorkingTimes
  alias Backend.Users.User

  describe "working_times" do
    alias Backend.WorkingTimes.WorkingTime
    alias Backend.Users.User
    import Backend.UsersFixtures
    import Backend.WorkingTimesFixtures

    @invalid_attrs %{start_time: nil, status: nil, end_time: nil}

    test "list_working_times/0 returns all working_times" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      assert WorkingTimes.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      assert WorkingTimes.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      user = user_fixture()

      valid_attrs = %{start_time: ~N[2023-10-23 07:55:00], status: true, end_time: ~N[2023-10-23 07:55:00],user_id: user.id}
      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.create_working_time(valid_attrs)
      assert working_time.start_time == ~N[2023-10-23 07:55:00]
      assert working_time.status == true
      assert working_time.end_time == ~N[2023-10-23 07:55:00]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      update_attrs = %{start_time: ~N[2023-10-24 07:55:00], status: false, end_time: ~N[2023-10-24 07:55:00]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimes.update_working_time(working_time, update_attrs)
      assert working_time.start_time == ~N[2023-10-24 07:55:00]
      assert working_time.status == false
      assert working_time.end_time == ~N[2023-10-24 07:55:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.update_working_time(working_time, @invalid_attrs)
      assert working_time == WorkingTimes.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      assert {:ok, %WorkingTime{}} = WorkingTimes.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimes.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      user = user_fixture()
      working_time = working_time_fixture(user.id)
      assert %Ecto.Changeset{} = WorkingTimes.change_working_time(working_time)
    end

  end
end
