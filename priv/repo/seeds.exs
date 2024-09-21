# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Twittex.Repo.insert!(%Twittex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Twittex.Accounts
alias Twittex.Feed
alias Twittex.Feed.Tweek
alias Twittex.Repo

{:ok, user} =
  Accounts.register_user(%{
    username: "phoenixonrails",
    email: "hello@phoenixonrails.com",
    password: "password123456"
  })

# user = Accounts.get_user_by_username!("phoenixonrails")

[
  "Phoenix rocks!",
  "just setting up my twittx",
  "Despite the constant negative press covfefe",
  "If only Bradley's arm was longer",
  "All Bitcoin sent to the address below will be sent back doubled!"
]
|> Enum.each(fn content ->
  {:ok, _user} = Feed.create_tweek_for_user(user, %{content: content})
end)

users =
  for name <- ~w(bill elon jeff mark) do
    username = String.capitalize(name)
    email = name <> "@phoenixonrails.com"
    password = "Secret123456"

    {:ok, user} = Accounts.register_user(%{username: username, email: email, password: password})
    Accounts.save_user_avatar!(user, name <> ".png")
    user
  end

{now, _} = NaiveDateTime.utc_now() |> NaiveDateTime.to_gregorian_seconds()

for _ <- 1..100 do
  Repo.insert!(%Tweek{
    content: Faker.Lorem.sentence(),
    user_id: Enum.random(users).id,
    inserted_at:
      NaiveDateTime.from_gregorian_seconds(now - :rand.uniform(30 * 24 * 60 * 60))
      |> DateTime.from_naive!("Etc/UTC")
  })
end
