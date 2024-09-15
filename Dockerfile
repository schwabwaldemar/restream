# Base image
FROM alpine:latest

# Install required packages
RUN apk update && \
    apk add --no-cache \
    build-base \
    pcre-dev \
    openssl-dev \
    zlib-dev \
    linux-headers \
    wget \
    git

# Set Nginx version
ENV NGINX_VERSION 1.25.2

# Download Nginx source code
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar zxvf nginx-${NGINX_VERSION}.tar.gz && \
    rm nginx-${NGINX_VERSION}.tar.gz

# Clone nginx-rtmp-module
RUN git clone https://github.com/arut/nginx-rtmp-module.git

# Build and install Nginx with RTMP module
RUN cd nginx-${NGINX_VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --add-module=../nginx-rtmp-module && \
    make && \
    make install

# Create necessary directories
RUN mkdir -p /usr/local/nginx/html /var/log/nginx /srv/hls

# Copy Nginx configuration
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Copy HTML files
COPY srv /usr/local/nginx/html

# Expose ports
EXPOSE 80 1935

# Start Nginx
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
