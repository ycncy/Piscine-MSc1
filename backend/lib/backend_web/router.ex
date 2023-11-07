defmodule BackendWeb.Router do
  use BackendWeb, :router

  import BackendWeb.AdminPlug
  import BackendWeb.ManagerPlug
  import BackendWeb.GeneralManagerPlug
  import BackendWeb.DefaultPlug

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug BackendWeb.AdminPlug
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :general_manager do
    plug BackendWeb.GeneralManagerPlug
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :manager do
    plug BackendWeb.ManagerPlug
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :default do
    plug BackendWeb.DefaultPlug
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
end
