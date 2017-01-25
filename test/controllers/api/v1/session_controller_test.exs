defmodule Notebook.Api.V1.SessionControllerTest do
  use Notebook.ConnCase
  import Notebook.Factory
  alias Notebook.{Endpoint, User}

  setup %{conn: conn} do
    user = build(:user) |> set_password("password1234") |> insert()
    user = Repo.get(User, user.id)
    {:ok, user: user, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create" do
    test "when the user information is correct", %{conn: conn, user: user} do
      params = %{email: user.email, password: "password1234"}
      resp = conn
      |> post(session_path(Endpoint, :create, session: params))
      |> json_response(:created)

      assert String.trim(resp["jwt"]) != ""
      assert resp["user"] == %{ "email" => user.email, "id" => user.id}
    end

    test "when the email is incorrect", %{conn: conn} do
      params = %{email: "foo@example.com", password: "password1234"}
      resp = conn
      |> post(session_path(Endpoint, :create, session: params))
      |> json_response(:unprocessable_entity)

      assert resp == %{"message" => "Invalid email or password"}
    end

    test "when the password is incorrect", %{conn: conn, user: user} do
      params = %{email: user.email, password: "wrong"}
      resp = conn
      |> post(session_path(Endpoint, :create, session: params))
      |> json_response(:unprocessable_entity)

      assert resp == %{"message" => "Invalid email or password"}
    end
  end

  describe "delete" do
    test "with a valid jwt", %{conn: conn, user: user} do
      {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

      resp = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(session_path(Endpoint, :delete))
      |> json_response(:ok)

      assert resp == %{"message" => "Logged out"}
    end

    test "without a jwt", %{conn: conn} do
      resp = conn
      |> delete(session_path(Endpoint, :delete))
      |> json_response(:unprocessable_entity)

      assert resp == %{"message" => "Something went wrong"}
    end
  end
end
