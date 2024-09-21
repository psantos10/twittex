defmodule TwittexWeb.ProfileLive do
  use TwittexWeb, :live_view

  import TwittexWeb.FeedComponents

  alias Twittex.Accounts
  alias Twittex.Feed

  def mount(%{"username" => username}, _session, socket) do
    user = Accounts.get_user_by_username!(username)
    tweeks = Feed.list_tweeks_for_user(user)

    socket =
      socket
      |> assign(:user, user)
      |> assign(:tweeks, tweeks)

    {:ok, socket}
  end
end
