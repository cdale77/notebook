defmodule Notebook.Api.V1.NoteControllerTest do
  use Notebook.ConnCase
  import Notebook.Factory
  alias Notebook.Endpoint

  setup %{conn: conn} do
    user = build(:user) |> set_password("password1234") |> insert()
    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)
    book = insert(:book)
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, conn: conn, jwt: jwt, book: book}
  end

  describe "show" do
    test "with an invalid jwt", %{conn: conn, book: book} do
      note = insert(:note, book: book)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> get(book_note_path(Endpoint, :show, book, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt, book: book} do
      note = insert(:note, book: book)
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> get(book_note_path(Endpoint, :show, book, note))
      |> json_response(:ok)

      assert resp["data"]["note"]["name"] == "Test Note"
      assert resp["data"]["note"]["note_html"] == "<h2>Test</h2>"
    end
  end

  describe "index" do
    test "with an invalid jwt", %{conn: conn, book: book} do
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> get(book_note_path(Endpoint, :index, book))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt, book: book} do
      insert(:note, book: book)
      insert(:note, book: book)
      insert(:note)

      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> get(book_note_path(Endpoint, :index, book))
      |> json_response(:ok)

      assert length(resp["data"]["notes"]) == 2
    end
  end

  describe "create" do
    test "with an invalid jwt", %{conn: conn, book: book} do
      note_params = %{ name: "Test", note_html: "<html></html>" }
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> post(book_note_path(Endpoint, :create, book, note: note_params))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt, book: book} do
      note_params = %{ name: "Test", note_html: "<html></html>" }
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> post(book_note_path(Endpoint, :create, book, note: note_params))
      |> json_response(:created)

      assert resp["data"]["note"]["name"] == "Test"
      assert resp["data"]["note"]["note_html"] == "<html></html>"
      assert resp["data"]["note"]["book_id"] == book.id
    end
  end

  describe "update" do
    test "with an invalid jwt", %{conn: conn, book: book} do
      note = insert(:note, book: book)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> put(book_note_path(Endpoint, :update, book, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt, book: book} do
      note = insert(:note, book: book)
      note_params = %{name: "New name", note_html: "<html><h1></h1></html"}
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> put(book_note_path(Endpoint, :update, book, note, note: note_params))
      |> json_response(:ok)

      assert resp["data"]["note"]["name"] == "New name"
      assert resp["data"]["note"]["note_html"] == "<html><h1></h1></html"
    end
  end

  describe "delete" do
    test "with an invalid jwt", %{conn: conn, book: book} do
      note = insert(:note, book: book)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> delete(book_note_path(Endpoint, :delete, book, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end
  end
end
