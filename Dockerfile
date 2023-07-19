# Use the base Ubuntu image
FROM ubuntu:latest

# Install the Nginx web server
RUN apt-get update && apt-get install -y nginx

# Copy the index.html file to the default Nginx web server directory
COPY index.html /var/www/html/

# Expose port 80 for web traffic
EXPOSE 80

# Start the Nginx web server when the container starts
CMD ["nginx", "-g", "daemon off;"]