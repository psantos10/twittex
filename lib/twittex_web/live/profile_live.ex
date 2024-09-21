defmodule TwittexWeb.ProfileLive do
  use TwittexWeb, :live_view

  import TwittexWeb.FeedComponents

  alias Twittex.Accounts
  alias Twittex.Feed
  alias Twittex.Feed.Tweek

  on_mount {TwittexWeb.UserAuth, :mount_current_user}

  def mount(%{"username" => username}, _session, socket) do
    user = Accounts.get_user_by_username!(username)
    tweeks = Feed.list_tweeks_for_user(user)
    form = Feed.change_tweek(%Tweek{}) |> to_form()

    socket =
      socket
      |> assign(:user, user)
      |> assign(:tweeks, tweeks)
      |> assign(:form, form)

    {:ok, socket}
  end
end
