# Nginx RTMP Streaming Service

This project sets up a live streaming web service using Nginx with the RTMP module and HLS (HTTP Live Streaming) support.
The service uses Docker and streams content in the `.m3u8` format.

## Features

- Live streaming with HLS and RTMP support.
- Nginx compiled with the RTMP module.
- Web interface to display live video using the HLS.js library.
- Streams available on both HTTP (`.m3u8`) and RTMP (`rtmp://`).

## Requirements

- Docker and Docker Compose installed on your system.
- A streaming tool that supports RTMP (e.g., OBS Studio).
- A web browser to view the live stream.
- A server with ports 80 and 1935 open.
- Basic knowledge of streaming protocols and Nginx configuration.

## Installation

1. Clone the Repository:

    ```bash
    git clone <repository_url>
    cd <repository_folder>
    ```
2. Build the Docker Image:

   Use Docker Compose to build the service:

    ```bash
    docker-compose up --build
    ```

   This will build the Nginx server with RTMP support and set up the necessary directories.
3. Start the Service:

   After building, start the service:

    ```bash
    docker-compose up
    ```

   This will launch the Nginx server on port 80 for HTTP and 1935 for RTMP.
4. Stream Setup

    - **Streaming via RTMP:**
        - Use an RTMP-compatible streaming tool (e.g., OBS Studio) to stream to the RTMP URL.
        - The RTMP URL will be:

            ```bash
            rtmp://<your_server_ip>/live
            ```
        - Attention: No authentication is set up by default. Make sure to secure your stream if needed.

    - **View the Stream (HLS):**
        - The live stream can be viewed via HTTP using the `.m3u8` playlist. Open a browser and navigate to:

            ```bash
            http://<your_server_ip>
            ```

        - The webpage will load an HTML5 video player using HLS.js that plays the live stream.
    - **Files and Directories:**
        - `nginx.conf`: Nginx configuration file (should include RTMP and HLS setup).
        - `srv/`: Directory containing the web files, including `index.html` and other necessary files.
            - `index.html`: This is the web page that uses HLS.js to display the live stream.
        - `Dockerfile`: Instructions to build the Nginx image with RTMP and HLS support.
        - `docker-compose.yml`: Defines the Nginx service and exposes ports for RTMP and HTTP streaming.

## Nginx Configuration

The Nginx server is configured to handle:

- RTMP streaming on port 1935.
- HLS streaming on port 80, with `.m3u8` playlist files served from the `/srv/hls` directory.
- Make sure your `nginx.conf` file is correctly set up to support both RTMP and HLS streaming.
- **Exposed Ports:**
    - `80`: HTTP port to serve the HLS stream and web interface.
    - `1935`: RTMP port for streaming via an RTMP-compatible streaming tool.

This project sets up a live streaming service using Nginx with the RTMP module and HLS (HTTP Live Streaming) support.
The service uses Docker and streams content in the .m3u8 format.
Features

## Debugging

- **Check the Logs:**
- If the stream does not start, check the logs:

    ```bash
    docker logs nginx-rtmp
    ```

## License

This project is licensed under the MIT License.