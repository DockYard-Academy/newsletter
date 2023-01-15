defmodule Newsletter.Emails do
  import Swoosh.Email

  @sender_email "brooklin.myers@dockyard.com"
  @sender_name "Brooklin"

  def welcome(user) do
    new()
    |> to({user.name, user.email})
    |> from({@sender_name, @sender_email})
    |> subject("Welcome to the DockYard Academy Newsletter")
    |> html_body("<h1>Hello #{user.name}</h1>")
    |> text_body("Hello #{user.name}")
  end
end
