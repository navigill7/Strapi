# Step 1: Build Admin Panel
FROM node:22-bullseye-slim as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Production Image
FROM node:22-bullseye-slim

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY --from=builder /app .

ENV NODE_ENV=production


EXPOSE 1337
CMD ["node", "dist/index.js"]
