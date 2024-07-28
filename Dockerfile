
FROM node:10

# Set the working directory
WORKDIR /home/node/app

# Copy package.json and package-lock.json (if available) and install dependencies
COPY test/package*.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Change ownership of the copied files to node
RUN chown -R node:node /home/node/app

# Switch to the node user
USER node

EXPOSE 3000

# Start the application
CMD [ "node", "src/000.js" ]

