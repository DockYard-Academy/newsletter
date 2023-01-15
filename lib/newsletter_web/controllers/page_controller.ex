defmodule NewsletterWeb.PageController do
  use NewsletterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
