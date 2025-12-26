# Stage 1: Build the React App
FROM node:18-alpine as build
WORKDIR /app
COPY /cicd/package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx (Lightweight)
FROM nginx:alpine
# Copy built assets from Stage 1 to Nginx folder
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
