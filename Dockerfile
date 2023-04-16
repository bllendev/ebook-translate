# Use the official NVIDIA CUDA image as a parent image
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt .

# Set the environment variable to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.8, other dependencies, and NVIDIA libraries
RUN apt-get update && apt-get install -y \
  software-properties-common \
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt-get update \
  && apt-get install -y \
  python3.8 \
  python3-pip \
  libcudnn8 \
  libcudnn8-dev \
  && rm -rf /var/lib/apt/lists/* \
  && pip3 install --no-cache-dir -r requirements.txt

# Set the environment variable for TensorFlow to use the GPU
ENV TF_FORCE_GPU_ALLOW_GROWTH=true

# Copy the application files
COPY . .

# Make port 80 available to the world outside this container
EXPOSE 80

# Run Uvicorn server when the container launches
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]
