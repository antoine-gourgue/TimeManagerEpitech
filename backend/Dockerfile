FROM elixir:1.15

# Créer un répertoire pour notre application
WORKDIR /app

# Copier uniquement les fichiers nécessaires pour les dépendances
COPY backend/mix.exs ./

# Supprimer le répertoire _build s'il existe
RUN rm -rf backend/_build

# Installer les dépendances
RUN mix deps.get && mix deps.compile

# Copier le contenu du dossier backend dans le répertoire de travail
COPY . .

# Compiler l'application
RUN mix compile

# Commande de démarrage
CMD ["mix", "phx.server"]
