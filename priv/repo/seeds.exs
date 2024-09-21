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

user = Accounts.get_user_by_username!("phoenixonrails")

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
