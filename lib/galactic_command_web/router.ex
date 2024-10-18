defmodule GalacticCommandWeb.Router do
  use GalacticCommandWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GalacticCommandWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GalacticCommandWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/planets", PlanetLive.Index, :index
    live "/planets/new", PlanetLive.Index, :new
    live "/planets/:id/edit", PlanetLive.Index, :edit

    live "/planets/:id", PlanetLive.Show, :show
    live "/planets/:id/show/edit", PlanetLive.Show, :edit

    live "/missions", MissionLive.Index, :index
    live "/missions/new", MissionLive.Index, :new
    live "/missions/:id/edit", MissionLive.Index, :edit

    live "/missions/:id", MissionLive.Show, :show
    live "/missions/:id/show/edit", MissionLive.Show, :edit
  end
end
