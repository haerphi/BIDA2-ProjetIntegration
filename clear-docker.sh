#!/bin/bash

# shut down the containers
docker compose -p tennis-club down

# remove the volumes
docker volume rm tennis-club_postgres_data
docker volume rm tennis-club_client_node_modules
docker volume rm tennis-club_stripe_config

# remove images
docker rmi tennis-club-api
docker rmi tennis-club-client

# if -r is present, remove the folders
if [ "$1" = "-r" ]; then
    echo "Removing folders..."
    rm -rf BIDA2-ProjetIntegration-API
    rm -rf BIDA2-ProjetIntegration-Client
    echo "Folders removed."
fi