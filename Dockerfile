# FIX 1: Use Node 22 (required for newer Vite versions)
FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json .
# Use 'npm ci' if you have a lockfile, otherwise 'npm install'
RUN npm ci 

COPY . .

# DEBUG STEP: This lists files in the logs so we can verify index.html exists
RUN ls -la

# Run the build
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
