defmodule LivechatWeb.PageController do
  use LivechatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
