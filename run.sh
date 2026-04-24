#!/bin/bash

# check if the folders exists
if [ ! -d "BIDA2-ProjetIntegration-API" ]; then
    echo "BIDA2-ProjetIntegration-API not found"
    # git clone
    git clone https://github.com/haerphi/BIDA2-ProjetIntegration-API.git
fi

if [ ! -d "BIDA2-ProjetIntegration-Client" ]; then
    echo "BIDA2-ProjetIntegration-Client not found"
    # git clone
    git clone https://github.com/haerphi/BIDA2-ProjetIntegration-Client.git
fi

# wait for the folders to be created
while [ ! -d "BIDA2-ProjetIntegration-API" ]; do
    sleep 1
done

while [ ! -d "BIDA2-ProjetIntegration-Client" ]; do
    sleep 1
done

# If the .env doesn't exist, copy the .env.example to .env
if [ ! -f "BIDA2-ProjetIntegration-API/.env" ]; then
    cp BIDA2-ProjetIntegration-API/.env.example BIDA2-ProjetIntegration-API/.env

    # Ask the user for the google credentials
    read -p "Enter the Google Client ID: " GOOGLE_CLIENT_ID
    read -s -p "Enter the Google Client Secret: " GOOGLE_CLIENT_SECRET
    echo

    # Replace the GOOGLE_CLIENT_ID in the .env file
    sed -i "s/GOOGLE_CLIENT_ID=.*/GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID/" BIDA2-ProjetIntegration-API/.env
    # Append the GOOGLE_CLIENT_SECRET to the .env file
    echo "GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET" >> BIDA2-ProjetIntegration-API/.env
fi

# Setup the .env for the client with the Google Client ID
if [ ! -f "BIDA2-ProjetIntegration-Client/.env" ]; then
    if [ -f "BIDA2-ProjetIntegration-Client/.env.example" ]; then
        cp BIDA2-ProjetIntegration-Client/.env.example BIDA2-ProjetIntegration-Client/.env
    fi
    API_GOOGLE_CLIENT_ID=$(grep GOOGLE_CLIENT_ID BIDA2-ProjetIntegration-API/.env | cut -d '=' -f2)
    echo "" >> BIDA2-ProjetIntegration-Client/.env
    echo "VITE_GOOGLE_CLIENT_ID=$API_GOOGLE_CLIENT_ID" >> BIDA2-ProjetIntegration-Client/.env
fi

# launch the docker compose
docker compose -p tennis-club up -d --force-recreate

# wait for the docker compose to be ready
while ! docker compose -p tennis-club ps | grep -q "Up"; do
    sleep 1
done

# open the client & api docs in the browser
start http://localhost:5173
start http://localhost:8000/api/docs/
