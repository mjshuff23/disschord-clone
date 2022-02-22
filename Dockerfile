FROM node:12 AS build-stage

# Install backend dependencies
WORKDIR /backend
COPY backend/. .
RUN npm install
CMD ["npm", "start"]

WORKDIR /frontend
COPY frontend/. .
RUN npm install
RUN npm run build

# You have to set this because it should be set during build time.
ENV REACT_APP_BASE_URL="https://disschord.herokuapp.com"
ENV DATABASE_URL="postgres://pttdqtkertncbt:10bb6f057f56662499cf25a0035a2067e5003cea7cb56317a55c51cc98f7a93a@ec2-3-227-154-49.compute-1.amazonaws.com:5432/d39cklf0qcpclj"



# Backend
FROM node:12

EXPOSE 8080

WORKDIR /var/www
COPY . .
COPY --from=build-stage /frontend/build/* app/static/



