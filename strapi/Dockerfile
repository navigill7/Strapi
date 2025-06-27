FROM node:20-alpine

WORKDIR /opt/

# Copy all files
COPY . .

# Install node-gyp globally and dependencies
RUN npm install -g node-gyp \
    && npm config set fetch-retry-maxtimeout 600000 -g \
    && npm install

# Build the admin panel
RUN npm run build

# Expose port
EXPOSE 1337

#Use production start script
CMD ["npm", "run", "start"]


