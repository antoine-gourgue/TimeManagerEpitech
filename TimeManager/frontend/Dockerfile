# Utiliser une image légère de Node.js pour le développement
FROM node:18-alpine

# Créer le répertoire de l'application dans le conteneur
WORKDIR /app

# Copier uniquement les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances (cela est mis en cache à moins que package.json change)
RUN npm install

# Copier tout le reste du projet
COPY . .

# Exposer le port que Vite utilise en mode développement (par défaut 5173)
EXPOSE 5173

# Lancer le serveur de développement Vite
CMD ["npm", "run", "dev"]
