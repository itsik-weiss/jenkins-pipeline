FROM python:3.11-slim

WORKDIR /app

# Set environment variable with a default value
ENV CITY_NAME=jerusalem

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Command to run the app
CMD ["python", "app.py"]
