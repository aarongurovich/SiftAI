# Use an updated Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# --- Install System Dependencies (Doppler & Node.js) ---
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    # Added dependencies for matplotlib
    build-essential \
    pkg-config \
    fontconfig \
    libpng-dev \
    libfreetype6-dev \
    # --- Install Node.js (LTS version) ---
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    # --- Install Doppler CLI ---
    && curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
    && apt-get update \
    && apt-get install -y doppler \
    # --- Clean up ---
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY package.json .
RUN npm install

# --- Application Code & Dependencies ---
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV HOME=/app
# Expose the port the app runs on
EXPOSE 8000

# --- Run the Application with Doppler ---
# Explicitly set the project and config to remove ambiguity
CMD ["doppler", "run", "--", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]