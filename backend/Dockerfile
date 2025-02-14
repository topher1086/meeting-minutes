FROM ubuntu:latest

# Install dependencies - Corrected libomp package name
RUN apt-get update && \
    apt-get install -y git cmake llvm libomp-dev build-essential python3 python3-venv pip

# Set up environment variables (adjust paths if needed)
ENV CC=gcc
ENV CXX=g++

# Create working directory
WORKDIR /app

# Clone whisper.cpp repository
RUN git clone --recursive https://github.com/ggerganov/whisper.cpp.git

# Copy custom server files
COPY whisper-custom /app/whisper.cpp/examples/server/

# Build whisper.cpp
WORKDIR /app/whisper.cpp
RUN mkdir build && cd build && \
    cmake .. && \
    make -j4

# Create package directory
WORKDIR /app
RUN mkdir -p whisper-server-package/models

# Copy server binary
RUN cp whisper.cpp/build/bin/whisper-server whisper-server-package/

# Copy models directory
COPY models whisper-server-package/models

# # Create run script
# COPY run-server.sh whisper-server-package/

# # Make run script executable
# RUN chmod +x whisper-server-package/run-server.sh

# # Set up backend
# WORKDIR /app/backend
# COPY backend/requirements.txt .
# RUN python3 -m venv venv && \
#     source venv/bin/activate && \
#     pip install -r requirements.txt

# COPY backend .

# # Set up environment variables
# COPY backend/temp.env backend/.env

# # Set default model
# ENV MODEL_NAME="ggml-small.bin"
# ENV MODEL_DIR="/app/whisper-server-package/models"

# # Download model (if it doesn't exist)
# RUN if [ ! -f "$MODEL_DIR/$MODEL_NAME" ]; then \
#         cd /app/whisper.cpp/models && ./download-ggml-model.sh small; \
#         mv "ggml-$MODEL_SHORT_NAME.bin" "$MODEL_DIR/"; \
#     fi

# # Set working directory for running the server
# WORKDIR /app/whisper-server-package

# # Expose port
# EXPOSE 8178

# # Run the server when the container starts
# CMD ["./run-server.sh"]