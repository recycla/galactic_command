defmodule GalacticCommandWeb.PageController do
  use GalacticCommandWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
