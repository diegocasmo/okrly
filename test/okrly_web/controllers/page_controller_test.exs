defmodule OkrlyWeb.PageControllerTest do
  use OkrlyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Home"
  end
end
