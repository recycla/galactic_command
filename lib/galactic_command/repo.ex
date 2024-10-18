defmodule GalacticCommand.Repo do
  use Ecto.Repo,
    otp_app: :galactic_command,
    adapter: Ecto.Adapters.SQLite3
end
