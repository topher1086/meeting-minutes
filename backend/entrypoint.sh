#!/bin/bash

# Get the model name from the environment variable or command-line argument
MODEL_SHORT_NAME="${MODEL_NAME:-small}"  # Default to "small" if not set

# Construct the model filename
MODEL_NAME="ggml-$MODEL_SHORT_NAME.bin"
MODEL_PATH="/app/models/$MODEL_NAME"

# Check if the model exists in the persistent volume
if [ ! -f "$MODEL_PATH" ]; then
    # Download the model
    cd /app/whisper.cpp/models
    ./download-ggml-model.sh "$MODEL_SHORT_NAME"
    mv "$MODEL_NAME" /app/models/
fi

# Run the command with the correct model path
exec "$@" --model "$MODEL_PATH"