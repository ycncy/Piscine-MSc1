defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/users", BackendWeb do
    pipe_through :api

    get "/", UserController, :get_user_by_credentials
    post "/", UserController, :create_user
    get "/:userID", UserController, :get_user_by_id
    put "/:userID", UserController, :update_user
    delete "/:userID", UserController, :delete_user
  end

  scope "/api/clocks", BackendWeb do
    pipe_through :api

    get "/:userID", ClockController, :get_clocks_by_userId
    post "/", ClockController, :create_clocking_time
  end

  scope "/api/workingtimes", BackendWeb do
    pipe_through :api

    get  "/:userID", WorkingTimeController, :get_all_working_times
    get  "/:userID/:id", WorkingTimeController, :get_one_working_time
    post "/:userID", WorkingTimeController, :create_working_time
    put "/:id", WorkingTimeController, :update_working_time
    delete "/:id", WorkingTimeController, :delete_working_time

  end
end
