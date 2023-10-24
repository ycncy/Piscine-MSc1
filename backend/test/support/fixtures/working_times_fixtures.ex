defmodule Backend.WorkingTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.WorkingTimes` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end_time: ~N[2023-10-23 07:55:00],
        start: ~N[2023-10-23 07:55:00],
        status: true
      })
      |> Backend.WorkingTimes.create_working_time()

    working_time
  end
end
