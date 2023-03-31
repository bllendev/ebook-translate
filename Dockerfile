# Use the official Python image as the base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the Pipfile and Pipfile.lock into the container
COPY Pipfile Pipfile.lock ./

RUN /usr/local/bin/python -m pip install --upgrade pip

# Install pipenv and the required packages
RUN pip install --no-cache-dir pipenv && pipenv install --ignore-pipfile --deploy --system

# Copy the rest of the application code into the container
COPY . .

# Expose the FastAPI application port
EXPOSE 8000

# Start the FastAPI application using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
