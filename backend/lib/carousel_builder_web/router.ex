defmodule CarouselBuilderWeb.Router do
  use CarouselBuilderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CarouselBuilderWeb do
    pipe_through :api

    resources "/carousels", CarouselController
    resources "/slides", SlideController
  end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:carousel_builder, :dev_routes) do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
