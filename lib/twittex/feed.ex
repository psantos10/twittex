defmodule Twittex.Feed do
  import Ecto.Query

  alias Twittex.Accounts.User
  alias Twittex.Feed.Tweek
  alias Twittex.Repo

  def list_tweeks_for_user(%User{} = user) do
    user
    |> Ecto.assoc(:tweeks)
    |> preload(:user)
    |> order_by([m], desc: m.inserted_at, desc: m.id)
    |> Repo.all()
  end

  def create_tweek_for_user(%User{} = user, attrs \\ %{}) do
    with {:ok, tweek} <-
           user
           |> Ecto.build_assoc(:tweeks)
           |> Tweek.changeset(attrs)
           |> Repo.insert() do
      {:ok, Repo.preload(tweek, :user)}
    end
  end

  def change_tweek(%Tweek{} = tweek, attrs \\ %{}) do
    Tweek.changeset(tweek, attrs)
  end
end
