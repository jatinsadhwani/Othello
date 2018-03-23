defmodule Othello.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :gamename, :string, null: false

      timestamps()
    end

  end
end
