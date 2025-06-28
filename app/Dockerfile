# Use official Node.js runtime with Alpine (smaller, more secure)
FROM node:20-alpine AS builder

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy app source
COPY . .

# Download AWS RDS SSL certificate
RUN wget -O ./global-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

# --- Runtime Stage ---
FROM node:20-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set working directory
WORKDIR /app

# Copy from builder stage
COPY --from=builder /app /app

# Set environment variables
ENV NODE_ENV=production \
    PORT=3000 \
    SSL_CERT_PATH=./global-bundle.pem

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "src/server.js"]
