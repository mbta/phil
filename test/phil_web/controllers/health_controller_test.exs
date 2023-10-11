defmodule PhilWeb.HealthControllerTest do
  use PhilWeb.ConnCase

  Application.compile_env(:phil, :redirect_http?, true)

  test "GET /_health responds with 200 when redirect_true? set and x-forwarded-proto header missing",
       %{
         conn: conn
       } do
    conn = get(conn, ~p"/_health")
    assert response(conn, 200) =~ "Ok"
  end
end
