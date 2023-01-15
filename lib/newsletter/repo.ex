defmodule Newsletter.Repo do
  use Ecto.Repo,
    otp_app: :newsletter,
    adapter: Ecto.Adapters.Postgres
end
