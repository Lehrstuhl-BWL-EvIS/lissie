defmodule LissieWeb.PageController do
  use LissieWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
