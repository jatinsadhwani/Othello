defmodule Othello.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :playername, :string, null: false
      add :games_id, references(:games, on_delete: :delete_all)

      timestamps()
    end

    create index(:players, [:games_id])
  end
end
