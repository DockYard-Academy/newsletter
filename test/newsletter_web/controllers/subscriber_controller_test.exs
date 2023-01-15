defmodule NewsletterWeb.SubscriberControllerTest do
  use NewsletterWeb.ConnCase
  use Oban.Testing, repo: Newsletter.Repo

  import Newsletter.SubscribersFixtures

  @create_attrs %{email: "some email", name: "some name"}
  @invalid_attrs %{email: nil, name: nil}

  describe "new subscriber" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.subscriber_path(conn, :new))
      assert html_response(conn, 200) =~ "New Subscriber"
    end
  end

  describe "create subscriber" do
    test "redirects to create when data is valid", %{conn: conn} do
      conn = post(conn, Routes.subscriber_path(conn, :create), subscriber: @create_attrs)

      assert redirected_to(conn) == Routes.subscriber_path(conn, :new)

      conn = get(conn, Routes.subscriber_path(conn, :new))
      assert html_response(conn, 200) =~ "New Subscriber"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.subscriber_path(conn, :create), subscriber: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Subscriber"
    end
  end
end
