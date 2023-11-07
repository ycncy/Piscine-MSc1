defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug BackendWeb.CorsMiddleware
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug BackendWeb.AdminPlug
    plug BackendWeb.CorsMiddleware
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :general_manager do
    plug BackendWeb.GeneralManagerPlug
    plug BackendWeb.CorsMiddleware
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :manager do
    plug BackendWeb.ManagerPlug
    plug BackendWeb.CorsMiddleware
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :default do
    plug BackendWeb.DefaultPlug
    plug BackendWeb.CorsMiddleware
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/api/authentication", BackendWeb do
    pipe_through :api
    post "/login", SessionUserController, :login

    pipe_through :default
    post "/logout", SessionUserController, :logout
  end

  scope "/api/users", BackendWeb do
    pipe_through :default
    get "/:userID", UserController, :get_user_by_id
    get "/", UserController, :get_user_by_credentials

    pipe_through :general_manager
    get "/admin/all", UserController, :get_all
    put "/:userID", UserController, :update_user
    delete "/:userID", UserController, :delete_user
    post "/delete", UserController, :delete_all_users
  end

  scope "/api/users", BackendWeb do
    pipe_through :admin
    post "/", UserController, :create_user
  end

  scope "/api/clocks", BackendWeb do
    pipe_through :default

    get "/:userID", ClockController, :get_clocks_by_userId
    post "/:userID", ClockController, :create_clocking_time
  end

  scope "/api/workingtimes", BackendWeb do
    pipe_through :default
    get  "/:userID", WorkingTimeController, :get_all_working_times
    get  "/:userID/:id", WorkingTimeController, :get_one_working_time

    pipe_through :manager
    put "/:id", WorkingTimeController, :update_working_time
    delete "/:id", WorkingTimeController, :delete_working_time
    post "/:userID", WorkingTimeController, :create_working_time
  end

  defp valid_api_key(conn, _opts) do
    key = System.get_env("ADMINKEY")
    case hd(get_req_header(conn, "api-key")) do
      ^key ->
        conn
      _ ->
        conn
        |> put_status(403)
        |> json(%{error: "Forbidden"})
    end
  end

  pipeline :api_key_required do
    plug :valid_api_key
  end

  scope "/api/protected", BackendWeb do
    pipe_through :api_key_required

    post "/create", UserController, :create_user
  end
end
