defmodule Lissie.Repo do
  use Ecto.Repo,
    otp_app: :lissie,
    adapter: Ecto.Adapters.Postgres
end
