defmodule Okrly.Repo do
  use Ecto.Repo,
    otp_app: :okrly,
    adapter: Ecto.Adapters.Postgres
end
