defmodule Backend.WorkingTimes.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field :status, :boolean, default: false
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start_time, :end_time, :status, :user_id])
    |> validate_required([:start_time, :end_time, :status, :user_id])
  end
end
