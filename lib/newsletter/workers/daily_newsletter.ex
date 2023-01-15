defmodule Newsletter.Workers.DailyNewsletter do
  use Oban.Worker, queue: :default, max_attempts: 10

  @day 60 * 60 * 24

  @impl true
  def perform(%{args: user, attempt: 1}) do
    user
    |> new(schedule_in: @day)
    |> Oban.insert!()

    Newsletter.Emails.welcome(user)
    |> Newsletter.Mailer.deliver()
  end

  def perform(%{args: user}) do
    Newsletter.Emails.welcome(user)
    |> Newsletter.Mailer.deliver()
  end
end
