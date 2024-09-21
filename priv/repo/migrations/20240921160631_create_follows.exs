defmodule Twittex.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follower_id, references(:users, on_delete: :delete_all), null: false
      add :followed_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:follows, [:follower_id])
    create index(:follows, [:followed_id])
    create unique_index(:follows, [:follower_id, :followed_id])
  end
end
