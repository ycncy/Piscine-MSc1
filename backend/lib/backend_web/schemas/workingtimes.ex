defmodule MyApp.WorkingTimes.WorkingTime do
  use Ecto.Schema

  schema "workingtimes" do
    field :start, :utc_datetime
    field :end_time, :utc_datetime
    belongs_to :user, MyApp.Users.User

    timestamps()
  end
end
