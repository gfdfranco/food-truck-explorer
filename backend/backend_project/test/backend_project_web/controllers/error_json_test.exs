defmodule BackendProjectWeb.ErrorJSONTest do
  use BackendProjectWeb.ConnCase, async: true

  test "renders 404" do
    assert BackendProjectWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert BackendProjectWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
