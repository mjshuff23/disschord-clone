FROM node:12 AS build-stage

WORKDIR /frontend
COPY frontend/. .

# You have to set this because it should be set during build time.
ENV REACT_APP_BASE_URL="https://disschord.herokuapp.com"

# Build our React App
RUN npm install
RUN npm run build


# Backend
FROM node:12

EXPOSE 8080

WORKDIR /var/www
COPY . .
COPY --from=build-stage /frontend/build/* app/static/

# Install backend dependencies
WORKDIR /backend
COPY backend/. .
RUN npm install
RUN npm start

