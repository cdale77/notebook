defmodule Notebook.PageControllerTest do
  use Notebook.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Notebook"
  end
end
