defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BackendWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

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

  if Application.compile_env(:backend, :dev_routes) do
  end
end
