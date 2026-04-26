#!/bin/bash

REMOVE_REPOSITORIES=false
FORCE_REMOVE_REPOSITORIES=false

# Parse arguments
for arg in "$@"; do
    case $arg in
        -r)
            REMOVE_REPOSITORIES=true
            shift
            ;;
        -d)
            FORCE_REMOVE_REPOSITORIES=true
            shift
            ;;
        *)
            echo "Usage: $0 [-r] [-d]"
            exit 1
            ;;
    esac
done

# shut down the containers
docker compose -p tennis-club down

# remove the volumes
docker volume rm tennis-club_postgres_data
docker volume rm tennis-club_client_node_modules
docker volume rm tennis-club_stripe_config

# remove images
docker rmi tennis-club-api
docker rmi tennis-club-client

if [ "$REMOVE_REPOSITORIES" = true ]; then

    # check if -d is present
    if [ "$FORCE_REMOVE_REPOSITORIES" = true ]; then
        echo "Force removing folders..."
        echo "Warning: This will remove the folders and all their contents."
        echo "Are you sure you want to continue? (y/N)"
        read -r response
        if [ "$response" != "y" ]; then
            echo "Aborting..."
            exit 0
        fi
        rm -rf BIDA2-ProjetIntegration-API
        rm -rf BIDA2-ProjetIntegration-Client
        echo "Folders removed."
        exit 0
    fi
    
    echo "Checking if there are uncommited/unpushed changes in BIDA2-ProjetIntegration-API and BIDA2-ProjetIntegration-Client."
    if ! git diff --quiet BIDA2-ProjetIntegration-API; then
        echo "There are uncommited changes in BIDA2-ProjetIntegration-API. Please commit and push them first. Or use -d to force removal."
        exit 1
    fi
    if ! git diff --quiet BIDA2-ProjetIntegration-Client; then
        echo "There are uncommited changes in BIDA2-ProjetIntegration-Client. Please commit and push them first. Or use -d to force removal."
        exit 1
    fi

    echo "Removing folders..."
    rm -rf BIDA2-ProjetIntegration-API
    rm -rf BIDA2-ProjetIntegration-Client
    echo "Folders removed."
fi