defmodule Backend.WorkingTimesFixtures do
  import Backend.UsersFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.WorkingTimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{},id) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end_time: ~N[2023-10-23 07:55:00],
        start_time: ~N[2023-10-23 07:55:00],
        user_id: id
      })
      |> Backend.WorkingTimes.create_working_time()

    working_time
  end
end
