defmodule Notebook.Api.V1.SessionController do
  use Notebook.Web, :controller
  alias Notebook.User

  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => session_params}) do
    email = session_params["email"]
    pass = session_params["password"]

    case User.find_and_confirm_password(email, pass) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> render("show.json", user: user, jwt: jwt)

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: "Invalid email or password")
    end
  end

  def delete(conn, %{}) do
    jwt = Guardian.Plug.current_token(conn)
    case Guardian.Plug.claims(conn) do
      {:ok, claims} ->
        Guardian.revoke!(jwt, claims)
        conn
        |> put_status(:ok)
        |> render("delete.json", message: "Logged out")
      {_, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: "Something went wrong")

    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render("error.json", message: "Authentication required")
  end
end
