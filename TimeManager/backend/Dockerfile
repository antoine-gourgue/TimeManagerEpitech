# Utilisation d'une image Elixir alpine pour dev
FROM elixir:1.14-alpine

# Installer les dépendances système nécessaires
RUN apk add --no-cache build-base git npm postgresql-client

# Configurer le dossier de travail
WORKDIR /app

# Assurer l'installation de Hex et Rebar
RUN mix local.hex --force && mix local.rebar --force

# Copier mix.exs et mix.lock pour l'installation des dépendances
COPY mix.exs ./

# Copier les fichiers de configuration
RUN apk add --no-cache inotify-tools

# Installer toutes les dépendances, y compris celles de développement
RUN mix deps.get

# Copier tout le code source
COPY . .

# Compiler le projet (en mode dev par défaut)
RUN mix compile

# Ouvrir le port de développement
EXPOSE 4000

# Commande pour lancer Phoenix en mode dev
CMD ["mix", "phx.server"]
