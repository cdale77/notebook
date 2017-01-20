defmodule Notebook.Router do
  use Notebook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Notebook do
    pipe_through :browser

    get "/", PageController, :index
  end

   scope "/api", Notebook do
     pipe_through :api
     scope "/v1" do
       post "/sessions",   Api.V1.SessionController, :create
       delete "/sessions", Api.V1.SessionController, :delete
     end
   end
end
