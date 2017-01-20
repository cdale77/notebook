defmodule Notebook.Api.V1.SessionController do
  use Notebook.Web, :controller

  plug :scrub_params, "session", when action in [:create]

  def create(conn, params) do

  end
end
