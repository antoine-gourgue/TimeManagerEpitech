defmodule TimeManagerWeb.PageControllerTest do
  use TimeManagerWeb.ConnCase

  alias TimeManagerWeb.Router.Helpers, as: Routes


  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
