defmodule LivechatWeb.Live.Index do
  use Phoenix.LiveView

  alias Livechat.Chat
  alias Livechat.Chat.Message

  def mount(_, _session, socket) do
    IO.inspect("HELLO world!")
    if connected?(socket), do: Chat.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns) do
    LivechatWeb.ChatView.render("index.html", assigns)
  end

  def fetch(socket, user_name \\ nil) do
    assign(socket, %{
      user_name: user_name,
      messages: Chat.list_messages(),
      changeset: Chat.change_message(%Message{username: user_name})
    })
  end

  def handle_event("validate", %{"message" => params}, socket) do
    changeset =
      %Message{}
      |> Chat.change_message(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    params
    |> Chat.create_message()
    |> case do
      {:ok, message} -> {:noreply, fetch(socket, message.username)}
      {:error, reason} -> {:noreply, assign(socket, changeset: reason)}
    end
  end

  def handle_info({Chat, [:message, _event], _message}, socket) do
    {:noreply, fetch(socket, get_user_name(socket))}
  end

  def get_user_name(socket) do
    socket.assigns
    |> Map.get(:user_name)
  end
end
