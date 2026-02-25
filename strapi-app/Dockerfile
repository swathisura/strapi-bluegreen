FROM node:18-alpine

# Install dependencies for node-gyp
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy rest of the app
COPY . .

# Build Strapi admin panel
RUN npm run build

# Expose port
EXPOSE 1337

# Start Strapi
CMD ["npm", "start"]