# Use official Node.js 18 Alpine image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install all dependencies (including dev, useful for tests in CI/CD)
RUN npm install

# Copy rest of the app files
COPY . .

# Expose app port
EXPOSE 8080

# Run app
CMD ["npm", "start"]
