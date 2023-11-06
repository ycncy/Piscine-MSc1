defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api/users", BackendWeb do
    pipe_through :api

    get "/all", UserController, :get_all
    get "/", UserController, :get_user_by_credentials
    post "/", UserController, :create_user
    get "/:userID", UserController, :get_user_by_id
    put "/:userID", UserController, :update_user
    delete "/:userID", UserController, :delete_user
  end

  scope "/api/clocks", BackendWeb do
    pipe_through :api

    get "/:userID", ClockController, :get_clocks_by_userId
    post "/:userID", ClockController, :create_clocking_time
    post "/check_clock/:id", ClockController, :check_clock
    put "/:id", ClockController, :update_clock
  end

  scope "/api/workingtimes", BackendWeb do
    pipe_through :api

    get  "/:userID", WorkingTimeController, :get_all_working_times
    get  "/", WorkingTimeController, :get_list_working_times
    get  "/:userID/:id", WorkingTimeController, :get_one_working_time
    post "/:userID", WorkingTimeController, :create_working_time
    put "/:id", WorkingTimeController, :update_working_time
    delete "/:id", WorkingTimeController, :delete_working_time

  end
end
