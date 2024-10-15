defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    # Routes pour les utilisateurs (Users)
    resources "/users", UserController, except: [:new, :edit] do
      put "/promote", UserController, :promote
      get "/teams", UserTeamController, :list_teams  # Récupérer les équipes pour un utilisateur
      resources "/working_times", WorkingTimeController, only: [:index, :create]
    end

    # Routes pour les équipes (Teams)
    resources "/teams", TeamController, except: [:new, :edit] do
      get "/users", UserTeamController, :list_users  # Récupérer les utilisateurs pour une équipe
    end

    # Routes pour les rôles (Roles)
    resources "/roles", RoleController, except: [:new, :edit]

    # Routes pour les horloges (Clocks)
    resources "/clocks", ClockController, only: [:index, :show, :create, :update, :delete] do
      get "/users/:user_id", ClockController, :index_for_user  # Horloges pour un utilisateur spécifique
    end

    # Routes pour les temps de travail (Working Times)
    resources "/working_times", WorkingTimeController, except: [:new, :edit] do
      get "/users/:user_id", WorkingTimeController, :index_for_user  # Temps de travail pour un utilisateur
    end

    # Routes pour les logs d'audit (Audit Logs)
    resources "/audit_logs", AuditLogController, only: [:index, :show, :create, :delete]

    # Routes pour les associations utilisateurs-équipes (User Teams)
    resources "/user_teams", UserTeamController, except: [:new, :edit]

    # Route pour l'authentification (login)
    post "/login", SessionController, :login  # Endpoint pour la connexion
  end
end
