defmodule BackendWeb.TeamController do
  use BackendWeb, :controller
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Teams.Team
  alias Backend.Teams
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def get_all_teams(conn, _params) do
    teams = Teams.list_teams()
    conn
    |> put_status(200)
    |> json(teams)
  end

  def get_team_by_id(conn, %{"teamID" => team_id}) do
    case Integer.parse(team_id) do
      {team_id_int, _} ->
        query = from(x in User, where: x.team_id == ^team_id_int)

        with users <- Repo.all(query) do
          conn
          |> put_status(200)
          |> json(users)
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidTeamID", message: "Invalid team ID format"})
    end
  end

  def create_team(conn, %{"team" => team_params}) do
    case Teams.create_team(team_params) do
      {:ok, %Team{} = team} ->
        conn
        |> put_status(201)
        |> json(team)

      {:error, %Ecto.ConstraintError{message: error_message}} ->
        conn
        |> put_status(403)
        |> json(%{error: "ConstraintError", message: error_message})
      _ ->
        conn
        |> put_status(500)
        |> json(%{error: "InternalServerError", message: "Internal Server Error"})
    end
  end

  def delete_team(conn, %{"teamID" => team_id}) do
    case Integer.parse(team_id) do
      {team_id_int, ""} ->
        case Repo.get(Team, team_id_int) do
          nil ->
            conn
            |> put_status(404)
            |> json(%{error: "TeamNotFound", message: "Team not found"})
          team ->
            with {:ok, _} <- Teams.delete_team(team) do
              conn
              |> put_status(204)
              |> json(%{})
            end
        end
      :error ->
        conn
        |> put_status(400)
        |> json(%{error: "InvalidTeamID", message: "Invalid team ID format"})
    end
  end
end
