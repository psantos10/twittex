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

  def handle_event("save", %{"tweek" => tweek_params}, socket) do
    current_user = socket.assigns.current_user

    case Feed.create_tweek_for_user(current_user, tweek_params) do
      {:ok, tweek} ->
        socket =
          socket
          |> update(:tweeks, &[tweek | &1])
          |> assign(:form, %Tweek{} |> Feed.change_tweek() |> to_form())

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  def handle_event("validate", %{"tweek" => tweek_params}, socket) do
    form =
      %Tweek{}
      |> Feed.change_tweek(tweek_params)
      |> to_form()

    {:noreply, assign(socket, :form, form)}
  end
end
