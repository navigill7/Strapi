# 1. Build Stage
FROM node:20 AS builder

WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm install && npm install pg --save


COPY . .

# 2. Production 
FROM node:20-slim AS final

WORKDIR /app

COPY --from=builder /app /app

COPY package*.json ./
RUN npm install --production && npm install pg --save

EXPOSE 1337

CMD ["npm", "run", "develop"]
