#!/bin/bash

open_url() {
    if command -v xdg-open > /dev/null; then 
        # Linux (natif)
        xdg-open "$1"
    elif command -v open > /dev/null; then 
        # Mac
        open "$1"
    else 
        # Windows (Git Bash ou environnement natif)
        start "$1"
    fi
}

# check if the folders exists
if [ ! -d "BIDA2-ProjetIntegration-API" ]; then
    echo "BIDA2-ProjetIntegration-API not found"
    git clone https://github.com/haerphi/BIDA2-ProjetIntegration-API.git
fi

if [ ! -d "BIDA2-ProjetIntegration-Client" ]; then
    echo "BIDA2-ProjetIntegration-Client not found"
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
    
    if grep -q "GOOGLE_CLIENT_SECRET=" BIDA2-ProjetIntegration-API/.env; then
        sed -i "s/GOOGLE_CLIENT_SECRET=.*/GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET/" BIDA2-ProjetIntegration-API/.env
    else
        # check if the file end with a new line
        if [ -n "$(tail -c1 BIDA2-ProjetIntegration-API/.env)" ]; then
            echo "" >> BIDA2-ProjetIntegration-API/.env
        fi
        echo "GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET" >> BIDA2-ProjetIntegration-API/.env
    fi
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
open_url "http://localhost:5173"
open_url "http://localhost:8000/api/docs/"