defmodule Notebook.Api.V1.BookControllerTest do
  use Notebook.ConnCase
  import Notebook.Factory
  alias Notebook.Endpoint
  require IEx
  setup %{conn: conn} do
    user = build(:user) |> set_password("password1234") |> insert()
    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, conn: conn, jwt: jwt}
  end

  describe "create" do
    test "with an invalid jwt", %{conn: conn} do
      resp = conn
      |> put_req_header("authorization", "Bearer: 12121212")
      |> post(book_path(Endpoint, :create, book: %{name: "test"}))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> post(book_path(Endpoint, :create, book: %{name: "test"}))
      |> json_response(:created)

      assert resp["data"]["book"]["name"] == "test"
    end
  end

  describe "update" do
    test "with an invalid jwt", %{conn: conn} do
      book = insert(:book)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12121212")
      |> put(book_path(Endpoint, :update, book))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      book = insert(:book)
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> put(book_path(Endpoint, :update, book, book: %{name: "New Book"}))
      |> json_response(:ok)

      assert resp["data"]["book"]["name"] == "New Book"
    end
  end

  describe "index" do
    test "with an invalid jwt", %{conn: conn} do
      resp = conn
      |> put_req_header("authorization", "Bearer: 12121212")
      |> get(book_path(Endpoint, :index))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      insert(:book)
      insert(:book)
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> get(book_path(Endpoint, :index))
      |> json_response(:ok)

      assert length(resp["data"]["books"]) == 2
    end
  end
end
