defmodule Notebook.Api.V1.NoteControllerTest do
  use Notebook.ConnCase
  import Notebook.Factory
  alias Notebook.Endpoint

  setup %{conn: conn} do
    user = build(:user) |> set_password("password1234") |> insert()
    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)
    conn = put_req_header(conn, "accept", "application/json")
    {:ok, conn: conn, jwt: jwt}
  end

  describe "show" do
    test "with an invalid jwt", %{conn: conn} do
      note = insert(:note)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> get(note_path(Endpoint, :show, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      note = insert(:note)
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> get(note_path(Endpoint, :show, note))
      |> json_response(:ok)

      assert resp["data"]["note"]["name"] == "Test Note"
      assert resp["data"]["note"]["note_html"] == "<h2>Test</h2>"
    end
  end

  describe "index" do
    test "with an invalid jwt", %{conn: conn} do
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> get(note_path(Endpoint, :index))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      insert(:note)
      insert(:note)
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> get(note_path(Endpoint, :index))
      |> json_response(:ok)

      assert length(resp["data"]["notes"]) == 2
    end
  end

  describe "create" do
    test "with an invalid jwt", %{conn: conn} do
      note_params = %{ name: "Test", note_html: "<html></html>" }
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> post(note_path(Endpoint, :create, note: note_params))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      note_params = %{ name: "Test", note_html: "<html></html>" }
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> post(note_path(Endpoint, :create, note: note_params))
      |> json_response(:created)

      assert resp["data"]["note"]["name"] == "Test"
      assert resp["data"]["note"]["note_html"] == "<html></html>"
    end
  end

  describe "update" do
    test "with an invalid jwt", %{conn: conn} do
      note = insert(:note)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> put(note_path(Endpoint, :update, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

    test "with a valid jwt", %{conn: conn, jwt: jwt} do
      note = insert(:note)
      note_params = %{name: "New name", note_html: "<html><h1></h1></html"}
      resp = conn
      |> put_req_header("authorization", "Bearer: #{jwt}")
      |> put(note_path(Endpoint, :update, note, note: note_params))
      |> json_response(:ok)

      assert resp["data"]["note"]["name"] == "New name"
      assert resp["data"]["note"]["note_html"] == "<html><h1></h1></html"
    end
  end

  describe "delete" do
    test "with an invalid jwt", %{conn: conn} do
      note = insert(:note)
      resp = conn
      |> put_req_header("authorization", "Bearer: 12323343434")
      |> delete(note_path(Endpoint, :delete, note))
      |> json_response(:unauthorized)

      assert resp["message"] == "Authentication required"
    end

  end
end
