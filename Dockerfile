# Étape 1 : Construire l'application avec Node.js
FROM node:18-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npm run build
RUN ls -la /app/dist

####################################################################

# Étape 2 : Servir l'application avec Apache
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
