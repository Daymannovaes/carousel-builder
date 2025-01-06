defmodule CarouselBuilderWeb.Router do
  use CarouselBuilderWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", CarouselBuilderWeb do
    pipe_through :api

    resources "/carousels", CarouselController
    resources "/slides", SlideController

    put "/carousels/:id/slides", CarouselController, :update
    put "/carousels/:id/settings", CarouselController, :update_settings
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:carousel_builder, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
