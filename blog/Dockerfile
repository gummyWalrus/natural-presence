FROM node:lts-slim AS build
WORKDIR /app
COPY . .
COPY .env.prod .env
RUN npm install
RUN npm run build
# RUN npm ci --omit=dev
CMD ["node", "build"]