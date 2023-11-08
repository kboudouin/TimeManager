defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {ApiWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Corsica, origins: "http://44.207.191.254:5173",allow_headers: ["Authorization", "Content-Type"],credentials: true)
  end

  pipeline :api_auth do
    plug(:accepts, ["json"])
    plug(Corsica, origins: "http://44.207.191.254:5173",allow_headers: ["Authorization", "Content-Type"],credentials: true)
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer", module: Api.Guardian, error_handler: ApiWeb.GuardianErrorHandler)
    plug(Guardian.Plug.LoadResource, allow_blank: true, module: Api.Guardian)
    plug(Guardian.Plug.EnsureAuthenticated, error_handler: ApiWeb.GuardianErrorHandler)
  end



  scope "/", ApiWeb do
    pipe_through(:browser)
    get("/", PageController, :home)
  end

   scope "/api", ApiWeb do
    pipe_through(:api)
    resources("/users", UserController, only: [:create])
    post("/login", UserController, :login)
  end
  # Other scopes may use custom stacks.
    scope "/api", ApiWeb do
      pipe_through(:api_auth)
      resources("/users", UserController, only: [:index, :show, :update, :delete])
      resources("/workingtimes", WorkingtimeController, only: [:delete, :update])
      get("/workingtimes/:userID", WorkingtimeController, :index)
      get("/workingtimes/:userID/:id", WorkingtimeController, :show)
      post("/workingtimes/:userID", WorkingtimeController, :create)
      resources("/clocks", ClockController, only: [:show, :index])
      post("/clocks/:userID", ClockController, :create)
      get("/teams", TeamController, :index)
      get("/teams/:id", TeamController, :show)
      post("/teams", TeamController, :create)
      delete("/teams/:id", TeamController, :delete)
    end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: ApiWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
