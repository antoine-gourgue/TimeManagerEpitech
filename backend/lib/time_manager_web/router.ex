defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug  # Ajouter CORSPlug pour toutes les routes API
  end

  # Nouveau pipeline pour l'authentification des utilisateurs
  pipeline :authenticated_user do
    plug TimeManagerWeb.Plugs.Authenticate
    plug :accepts, ["json"]
  end

  # Pipeline pour les gestionnaires
  pipeline :authenticated_manager do
    plug TimeManagerWeb.Plugs.AuthenticateManager
    plug :accepts, ["json"]
  end

  # Routes publiques
  scope "/api", TimeManagerWeb do
    pipe_through :api

    post "/login", SessionController, :login  # Endpoint pour la connexion
  end

  # Routes pour les utilisateurs (accessible uniquement aux utilisateurs authentifiés)
  scope "/api", TimeManagerWeb do
    pipe_through [:api, :authenticated_user]

    resources "/users", UserController, except: [:new, :edit] do
      put "/promote", UserController, :promote
      get "/teams", UserTeamController, :list_teams
    end

    # Routes pour les équipes
    resources "/teams", TeamController, except: [:new, :edit] do
      get "/users", UserTeamController, :list_users
    end

    # Routes pour les rôles
    resources "/roles", RoleController, except: [:new, :edit]

    # Routes pour les horloges
    resources "/clocks", ClockController, only: [:index, :show, :create, :update, :delete]

    get "/clocks/users/:user_id", ClockController, :index_for_user

    # Routes pour les temps de travail
    resources "/working_times", WorkingTimeController, except: [:new, :edit]

    get "/working_times/users/:user_id", WorkingTimeController, :index_for_user

    # Routes pour les logs d'audit
    resources "/audit_logs", AuditLogController, only: [:index, :show, :create, :delete]

    # Routes pour les associations utilisateurs-équipes
    resources "/user_teams", UserTeamController, except: [:new, :edit]
  end

  # Routes accessibles uniquement aux gestionnaires
  scope "/api", TimeManagerWeb do
    pipe_through [:api, :authenticated_manager]

    # Ajoutez ici des routes spécifiques aux gestionnaires
    # Par exemple:
    resources "/manager_specific", ManagerController, only: [:index, :show, :create]
  end
end
