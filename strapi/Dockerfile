# 1. Build Stage
FROM node:20 AS builder

WORKDIR /app

# Copy only package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install && npm install pg --save


COPY . .

# 2. Production Stage
FROM node:20-slim AS final

WORKDIR /app

COPY --from=builder /app /app

# Install only production dependencies
COPY package*.json ./
RUN npm install --production && npm install pg --save

EXPOSE 1337

CMD ["npm", "run", "develop"]
