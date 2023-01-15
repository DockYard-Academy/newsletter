defmodule NewsletterWeb.SubscriberController do
  use NewsletterWeb, :controller

  alias Newsletter.Subscribers
  alias Newsletter.Subscribers.Subscriber

  def new(conn, _params) do
    changeset = Subscribers.change_subscriber(%Subscriber{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subscriber" => subscriber_params}) do
    case Subscribers.create_subscriber(subscriber_params) do
      {:ok, subscriber} ->
        Newsletter.Workers.DailyNewsletter.new(%{name: subscriber.name, email: subscriber.email})
        |> Oban.insert!()

        conn
        |> put_flash(:info, "Subscriber created successfully.")
        |> redirect(to: Routes.subscriber_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
